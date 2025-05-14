
CREATE TABLE com_quotation (
    com_quotation_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO com_quotation (fecha_creacion) VALUES
(CURRENT_TIMESTAMP - INTERVAL '1 día'),
(CURRENT_TIMESTAMP - INTERVAL '3 días'),
(CURRENT_TIMESTAMP - INTERVAL '7 días'),
(CURRENT_TIMESTAMP - INTERVAL '10 días'),
(CURRENT_TIMESTAMP - INTERVAL '15 días');

CREATE TABLE com_quotation_line (
    com_quotation_line_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    com_quotation_id BIGINT NOT NULL,
    linea_id BIGINT,
    FOREIGN KEY (com_quotation_id) REFERENCES com_quotation(com_quotation_id)
);

INSERT INTO com_quotation_line (com_quotation_id, linea_id) VALUES
(1, 101),
(1, 102),
(2, 201),
(3, 301),
(4, 401);

CREATE TABLE cnt_medical_order_medicament (
    cnt_medical_order_medicament_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    cnt_medical_order_id BIGINT NOT NULL,
    FOREIGN KEY (cnt_medical_order_id) REFERENCES cnt_medical_order(cnt_medical_order_id)
);

INSERT INTO cnt_medical_order_medicament (cnt_medical_order_id) VALUES
(1),
(1),
(2),
(3),
(4);

CREATE TABLE cnt_medical_order_medicament_quotation (
    cnt_medical_order_medicament_quotation_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    linea_id BIGINT NOT NULL,
    cnt_medical_order_medicament_id BIGINT NOT NULL,
    FOREIGN KEY (linea_id) REFERENCES com_quotation_line(com_quotation_line_id),
    FOREIGN KEY (cnt_medical_order_medicament_id) REFERENCES cnt_medical_order_medicament(cnt_medical_order_medicament_id)
);

INSERT INTO cnt_medical_order_medicament_quotation (linea_id, cnt_medical_order_medicament_id) VALUES
(101, 1),
(102, 2),
(201, 3),
(301, 4),
(401, 5);

CREATE TABLE cnt_medical_order (
    cnt_medical_order_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    adm_admission_flow_id BIGINT NOT NULL,
    FOREIGN KEY (adm_admission_flow_id) REFERENCES adm_admission_flow(adm_admission_flow_id)
);

INSERT INTO cnt_medical_order (adm_admission_flow_id) VALUES
(1),
(2),
(3),
(4),
(5);

CREATE TABLE adm_admission_flow (
    adm_admission_flow_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    adm_admission_id BIGINT NOT NULL,
    FOREIGN KEY (adm_admission_id) REFERENCES adm_admission(adm_admission_id)
);

INSERT INTO adm_admission_flow (adm_admission_id) VALUES
(1),
(2),
(3),
(4),
(5);

CREATE TABLE adm_admission (
    adm_admission_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY
);

INSERT INTO adm_admission (adm_admission_id) VALUES
(1),
(2),
(3),
(4),
(5);

CREATE TABLE adm_admission_appointment (
    adm_admission_id BIGINT PRIMARY KEY,
    flujo_id BIGINT,
    FOREIGN KEY (flujo_id) REFERENCES sch_workflow_slot_assigned(sch_workflow_slot_assigned_id),
    FOREIGN KEY (adm_admission_id) REFERENCES adm_admission(adm_admission_id)
);

INSERT INTO adm_admission_appointment (adm_admission_id, flujo_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

CREATE TABLE sch_workflow_slot_assigned (
    sch_workflow_slot_assigned_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sch_slot_assigned_id BIGINT NOT NULL,
    FOREIGN KEY (sch_slot_assigned_id) REFERENCES sch_slot_assigned(sch_slot_assigned_id)
);

INSERT INTO sch_workflow_slot_assigned (sch_slot_assigned_id) VALUES
(1),
(2),
(3),
(4),
(5);

CREATE TABLE sch_slot_assigned (
    sch_slot_assigned_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sch_slot_id BIGINT NOT NULL,
    gbl_entity_paciente_id BIGINT NOT NULL,
    FOREIGN KEY (sch_slot_id) REFERENCES sch_slot(sch_slot_id),
    FOREIGN KEY (gbl_entity_paciente_id) REFERENCES gbl_entity(gbl_entity_id)
);

INSERT INTO sch_slot_assigned (sch_slot_id, gbl_entity_paciente_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 4);

CREATE TABLE gbl_entity (
    gbl_entity_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    tipo_entidad VARCHAR(50) NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    identificacion VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    CONSTRAINT chk_tipo_entidad CHECK (tipo_entidad IN ('PACIENTE', 'PROVEEDOR', 'OTRO'))
);

INSERT INTO gbl_entity (tipo_entidad, nombre, apellido, identificacion, telefono) VALUES
('PACIENTE', 'Ana', 'zapata', '12345', '1111111111'),
('PACIENTE', 'Luis', 'angulo', '67890', '2222222222'),
('PACIENTE', 'Sofía', 'martines', '13579', '3333333333'),
('PACIENTE', 'Carlos', 'rodiguez', '24680', '4444444444'),
('PROVEEDOR', 'Elena', 'cortes', '98765', '5555555555');

CREATE TABLE sch_slot (
    sch_slot_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    hora_inicio TIME WITHOUT TIME ZONE,
    hora_fin TIME WITHOUT TIME ZONE,
    sch_event_id BIGINT NOT NULL,
    FOREIGN KEY (sch_event_id) REFERENCES sch_event(sch_event_id)
);

INSERT INTO sch_slot (hora_inicio, hora_fin, sch_event_id) VALUES
('09:00:00', '09:30:00', 1),
('10:00:00', '10:30:00', 1),
('11:00:00', '11:30:00', 2),
('14:00:00', '14:30:00', 3),
('15:00:00', '15:30:00', 4);

CREATE TABLE sch_event (
    sch_event_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sch_calendar_id BIGINT NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (sch_calendar_id) REFERENCES sch_calendar(sch_calendar_id)
);

INSERT INTO sch_event (sch_calendar_id, fecha_inicio, fecha_fin) VALUES
(1, '2025-05-15', '2025-05-15'),
(1, '2025-05-15', '2025-05-15'),
(2, '2025-05-16', '2025-05-16'),
(3, '2025-05-17', '2025-05-17'),
(4, '2025-05-17', '2025-05-17');

CREATE TABLE sch_calendar (
    sch_calendar_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    gbl_entity_proveedor_id BIGINT NOT NULL,
    FOREIGN KEY (gbl_entity_proveedor_id) REFERENCES gbl_entity(gbl_entity_id)
);

INSERT INTO sch_calendar (gbl_entity_proveedor_id) VALUES
(5),
(5),
(5),
(5),
(5);