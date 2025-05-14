<?php
require 'db.php';

// Verifica si se ha enviado el formulario y si el campo 'id' no este vacío
if (isset($_POST['id']) && $_POST['id'] != '') {
    $id = $_POST['id'];

    /* 
    
    ### SQL
        * Se seleccionan los datos de la cotización, incluyendo el nombre y apellido del paciente,
        * la identificación del paciente, el nombre y apellido del profesional, la fecha y hora de la cita.
        * Se utilizan varias tablas para obtener la información necesaria.
        * Desido realiar un inner join entre las tablas  por motivo de que requiero información exacta de los datos insertados
          evito usar left join ya que solo requiero los datos que se encuentran en la tabla de cotización y cuenta con datos
          de las otras tablas.

          # uso adodb para realizar la consulta a la base de datos
            realizo la consulta a la base de datos y guardo el resultado en una variable
            ya que mas adelante en temas de escalabilidad puede hacer parte de una transacion mas grande 

            # variable $id es la que contiene el id de la cotización que se va aconsultar 
              $cmdSQL  realiza la ejecucion de la consulta a la base de datos
              ? es un marcador de posición que se reemplazará por el valor de $id
                al usar un marcador de posición, se evita la inyección SQL y se mejora la seguridad de la consulta.
                $cmdSQL->prepare($sql) prepara la consulta          
    */
    $sql = "SELECT".
    "p.first_name AS paciente_nombre, ".
    "p.last_name AS paciente_apellido, ".
    "p.identification AS paciente_identificacion ".
    "prof.first_name AS profesional_nombre, ".
    "prof.last_name AS profesional_apellido, ".
    "e.init_date AS fecha_cita, ".
    "s.init_time AS hora_cita ".
    "FROM com_quotation q ".
    "INNER JOIN com_quotation_line ql ON q.com_quotation_id = ql.com_quotation_id ".
    "INNER JOIN cnt_medical_order_medicament_quotation moq ON ql.com_quotation_line_id = moq.line_id ".
    "INNER JOIN cnt_medical_order_medicament mom ON moq.cnt_medical_order_medicament_id = cnt_medical_order_medicament_id ".
    "INNER JOIN cnt_medical_order mo ON mom.cnt_medical_order_id = mo.cnt_medical_order_id ".
    "INNER JOIN adm_admission_flow af ON mo.adm_admission_flow_id = af.adm_admission_flow_id ".
    "INNER JOIN adm_admission_appointment aa ON af.adm_admission_id = aa.adm_admission_id ".
    "INNER JOIN sch_workflow_slot_assigned wsa ON aa.flow_id = wsa.sch_workflow_slot_assigned_id ".
    "INNER JOIN sch_slot_assigned sa ON wsa.sch_slot_assigned_id = sa.sch_slot_assigned_id ".
    "INNER JOIN sch_slot s ON sa.sch_slot_id = s.sch_slot_id ".
    "INNER JOIN sch_event e ON s.sch_event_id = e.sch_event_id ".
    "INNER JOIN sch_calendar c ON e.sch_calendar_id = c.sch_calendar_id ".
    "INNER JOIN gbl_entity prof ON c.gbl_entity_provider_id = prof.gbl_entity_id ".
    "INNER JOIN gbl_entity p ON sa.gbl_entity_patient_id = p.gbl_entity_id ".
    "WHERE q.com_quotation_id = ?";

    $cmdSQL = $pdo->prepare($sql);
    $cmdSQL->execute([$id]);

    $rows = $cmdSQL->fetchAll(PDO::FETCH_ASSOC);

    if ($rows) {
        echo "<table border='1' cellpadding='10'>
                <thead>
                    <tr>
                        <th>Nombre del Paciente</th>
                        <th>Apellido del Paciente</th>
                        <th>Identificación</th>
                        <th>Nombre del Profesional</th>
                        <th>Apellido del Profesional</th>
                        <th>Fecha de Cita</th>
                        <th>Hora de Cita</th>
                    </tr>
                </thead>
                <tbody>";

        foreach ($rows as $row) {
            echo "<tr>
                    <td>{$row['paciente_nombre']}</td>
                    <td>{$row['paciente_apellido']}</td>
                    <td>{$row['paciente_identificacion']}</td>
                    <td>{$row['profesional_nombre']}</td>
                    <td>{$row['profesional_apellido']}</td>
                    <td>{$row['fecha_cita']}</td>
                    <td>{$row['hora_cita']}</td>
                  </tr>";
        }

        echo "  </tbody>
              </table>";
    } else {
        echo "<div class='alert alert-warning'>No se encontró información para la cotización ID $id.</div>";
    }
}
?>
