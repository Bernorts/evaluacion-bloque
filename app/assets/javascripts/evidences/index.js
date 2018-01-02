/*global $*/
function loadTabs() {
  $( "#nav-po_1-tab" ).addClass("active");
  $( "#nav-po_2-tab" ).removeClass("active");
  $( "#evidencias" ).addClass("show");
  $( "#evidencias" ).addClass("active");
  $( "#revisiones" ).removeClass("show");
  $( "#revisiones" ).removeClass("active");
}
window.onload = loadTabs;


$('#nav-po_1-tab').on('click', function (e) {
  e.preventDefault();
  e.stopPropagation();
  $( "#nav-po_1-tab" ).addClass("active");
  $( "#nav-po_2-tab" ).removeClass("active");
  $( "#evidencias" ).addClass("show");
  $( "#evidencias" ).addClass("active");
  $( "#revisiones" ).removeClass("show");
  $( "#revisiones" ).removeClass("active");
});

$('#nav-po_2-tab').on('click', function (e) {
  e.preventDefault();
  e.stopPropagation();
  $( "#nav-po_2-tab" ).addClass("active");
  $( "#nav-po_1-tab" ).removeClass("active");
  $( "#revisiones" ).addClass("show");
  $( "#revisiones" ).addClass("active");
  $( "#evidencias" ).removeClass("show");
  $( "#evidencias" ).removeClass("active");
});

function changeSubmitToAjax(id_modal, id_form, message) {
  console.log("entré", id_modal);
  $(id_form).keypress(function(e) {
   if (e.which == '13') {
     e.preventDefault();
     $(id_form).find(':submit').click();
     return false;
   }
  });

  $(id_form).submit(function(e){
    e.preventDefault();
    $.ajax({
      type: $(this).attr('method'),
      url: this.action,
      data: $(this).serialize(),
      context: this,
      success: function(data, status_code) {
        console.log(data);

        $(id_modal).modal('toggle'); // close modal
        console.log(data);

        swal({
          title: message,
          type: 'success',
          confirmButtonText: 'OK',
          timer: 3000,
        }).then(
        function (isConfirm) {
            if (isConfirm) {
                location.reload(); // reload page after closing
            }
        },
        function (isConfirm) {
          if (isConfirm) {
            location.reload(); // reload page after closing
          }
        });
      },
      error: function(data, status_code) {
        var json = data.responseJSON;
        console.log(json);
        var errors = '';
        var keys = Object.keys(json.errors);
        console.log(keys);
        for(var i = 0; i < keys.length; i++) {
          /*if(keys[i] == "business_name"){
            errors += 'La razón social ';
          }
          else if (keys[i] == "street_address"){
            errors += 'La dirección ';
          }
          */
          errors += json.errors[keys[i]] + "\n";

        }

        swal({
          title: 'Error!',
          text: errors, // obtain first error msg
          type: 'error',
          confirmButtonText: 'OK'
        });

        $(id_form).find(':submit').removeAttr('disabled');
        $(id_form).find(':submit').removeAttr('data-disable-with');
      }
    });
  });
}

$(document).ready(function(){
  console.log("DOCUMENT READY")
    changeSubmitToAjax('#saveEvidence', '.new_evidence', "Creación exitosa!");
    $('#editEvidence').modal({ show: false})
    $(".edit-evidence_types-link").on("click", function() {
        $.ajax({
            url: $(this).attr("href"),
            success: function(data) {
              console.log("DATA", data);
                $(data).appendTo(".modal-lg");
                changeSubmitToAjax('#editEvidence', '.edit_evidence', "Edición exitosa!");
                $('#editEvidence').modal('show');
            }
        });
    });
    $('#editEvidence').on('hidden.bs.modal', function () {
      $(".edit_evidence").remove();
    });


    $('.editAchLevel').change(function(e){
        e.preventDefault();
        var dynamicData = {};
        dynamicData["id"] = $(this).data('id');
        dynamicData["achLevel"] = $(this).val();
        var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
        console.log(AUTH_TOKEN)
        $.ajaxSetup({
          headers: {
            'X-CSRF-Token': AUTH_TOKEN
          }
        });
        $.ajax({
          url: "/evaluaciones/evaluate/" + dynamicData["id"],
          type: "PUT",
          data: dynamicData,
          success: function(response) {
            swal({
              title: "Evaluación registrada exitosamente",
              type: 'success',
              confirmButtonText: 'OK',
              timer: 1500,
            });
          },
        });
    });

    $('.editRetro').change(function(e){
        e.preventDefault();
        var dynamicData = {};
        dynamicData["id"] = $(this).data('id');
        dynamicData["retro"] = $(this).val();
        var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
        console.log(AUTH_TOKEN)
        $.ajaxSetup({
          headers: {
            'X-CSRF-Token': AUTH_TOKEN
          }
        });
        $.ajax({
          url: "/evaluaciones/feedback/" + dynamicData["id"],
          type: "PUT",
          data: dynamicData,
          success: function(response) {
            swal({
              title: "Retroalimentación registrada exitosamente",
              type: 'success',
              confirmButtonText: 'OK',
              timer: 1500,
            });
          },
        });
    });

    $('.incheck').change(function(e){
      e.preventDefault();
      var dynamicData = {};
      dynamicData["evaluation_id"] = $(this).data('id');
      dynamicData["user_id"] = $(this).val();
      var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
      console.log(AUTH_TOKEN)
      $.ajaxSetup({
        headers: {
          'X-CSRF-Token': AUTH_TOKEN
        }
      });

      if(this.checked) {
        $.ajax({
          url: "/evaluaciones/evaluator/" + dynamicData["evaluation_id"],
          type: "POST",
          data: dynamicData,
          success: function(response) {
            swal({
              title: "Profesor añadido a la evaluación correctamente",
              type: 'success',
              confirmButtonText: 'OK',
              timer: 1500,
            });
          },
        });
      } else{
        $.ajax({
          url: "/evaluaciones/evaluator/" + dynamicData["evaluation_id"],
          type: "DELETE",
          data: dynamicData,
          success: function(response) {
            swal({
              title: "Profesor eliminado de la evaluación correctamente",
              type: 'success',
              confirmButtonText: 'OK',
              timer: 1500,
            });
          },
        });
      }

    })


});
