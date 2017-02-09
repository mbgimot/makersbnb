$(document).ready(function(){
  var date_input=$('input[name="date"]');
  var options={
    format: 'dd/mm/yyyy',
    todayHighlight: true,
    autoclose: true,
  };
  $("#space_datepicker").datepicker(options);
  $("#space_datepicker").on('changeDate', function(){
    $("#hidden_date").val(
      $('#space_datepicker').datepicker('getFormattedDate')
    );
  });

  });
