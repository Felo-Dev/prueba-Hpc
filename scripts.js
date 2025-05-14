$(document).ready(function () {
  $('#form-busqueda').submit(function (e) {
    e.preventDefault();

    $.ajax({
      url: 'controller.php',
      type: 'POST',
      data: { id: $('#buscar').val() },
      success: function (data) {
        $('#resultado').html(data);

        if (data.includes('<table')) {
          Notiflix.Notify.success('Resultados encontrados');
        } else if (data.includes('No se encontró información')) {
          Notiflix.Notify.warning('No se encontraron resultados');
        } else {
          Notiflix.Notify.info('Consulta completada');
        }
      },
      error: function () {
        $('#resultado').html('<div class="alert alert-danger">Error al buscar.</div>');
        Notiflix.Notify.failure('Error en la búsqueda');
      }
    });
  });
});
