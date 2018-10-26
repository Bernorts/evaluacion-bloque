// append row to the HTML table
var countR = 0, countC = 0;
function appendRow() {
    var tbl = document.getElementById('comp-table'), // table reference
        row = tbl.insertRow(tbl.rows.length-1),      // append table row
        i;
    // insert table cells to the new row
    row.id = 'addedrow' + countR;
    createCell(row.insertCell(0), 'textarea', 'form-control', 'firstCol', 'Descripción', 'new_competences_descriptions[' + countR + ']');
    createCell(row.insertCell(1), 'textarea', 'form-control', 'evidences', 'Evidencias', 'new_competences_evidences[' + countR + ']');
    for (i = 2; i < tbl.rows[0].cells.length-1; i++) {
        createCell(row.insertCell(i), 'textarea', 'form-control', '', 'Descripción', 'new_competences_levels[' + countR + ',' + i + ']');
    }
    createCell(row.insertCell(i), 'button', 'btn btn-danger btn-circle btn-lg', 'deleteRow', countR, '');
    countR += 1;
}
 
// create DIV element and append to the table cell
function createCell(cell, text, style, extra, placeholder, name) {
    var div = document.createElement('div'), // create DIV element
        txt = document.createElement(text);
    if(text == 'input'){
      txt.type = "text";
      cell.setAttribute('class', 'accept-drag');
    }
    if(text == 'button'){
        if(extra == 'deleteColumn'){
            cell.id = 'addedcol' + placeholder;
        }
        txt.setAttribute('onclick', extra + '(' + placeholder + ', "added")')
        txt.type = "button"
        txt.innerHTML = '<i class="fa fa-minus" aria-hidden="true"></i>'
    }
    if(extra == 'firstCol'){
      var ex = document.createElement('input')
      ex.type = 'text'
      ex.setAttribute('class', style);        // set DIV class attribute
      ex.setAttribute('placeholder', 'Nombre')
      ex.name = 'new_competences_names[' + countR + ']';
      div.appendChild(ex)
    }
    txt.name = name;
    div.appendChild(txt);                    // append text node to the DIV
    txt.setAttribute('class', style);        // set DIV class attribute
    txt.setAttribute('placeholder', placeholder);
    cell.appendChild(div);                   // append DIV to the table cell
}

// append column to the HTML table
function appendColumn() {
    var tbl = document.getElementById('comp-table'), // table reference
        i;
    // open loop for each row and append cell
    createCell(tbl.rows[0].insertCell(tbl.rows[0].cells.length-1), 'input', 'form-control', '', 'Nombre', 'new_levels_names[' + countC + ']');
    for (i = 1; i < tbl.rows.length-1; i++) {
        createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length-1), 'textarea', 'form-control', '', 'Descripción', 'new_levels_competences[' + countC + ',' + i + ']');
    }
    countC += 1;
    createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), 'button', 'btn btn-danger btn-circle btn-lg', 'deleteColumn', countC, '');
}

function deleteRow(id, extra) {
    var tbl = document.getElementById('comp-table'), // table reference
    index = document.getElementById(extra + 'row' + id);
    tbl.deleteRow(index.rowIndex);
}
 
function deleteColumn(id, extra) {
    var tbl = document.getElementById('comp-table'), // table reference
        lastCol = tbl.rows[0].cells.length - 1,    // set the last column index
        index = document.getElementById(extra + 'col' + id), i;
    // delete cells with index greater then 0 (for each row)
    for (i = 0; i < tbl.rows.length; i++) {
        tbl.rows[i].deleteCell(index.cellIndex);
    }
}


$( document ).on('ready turbolinks:load',function() {

  var draggable = false;


  $('#toggle-drag').click(function(){
    draggable = !draggable;
    console.log("Toggle drag", draggable);
    if(draggable){

      $('#toggle-drag').addClass('active focus');

      $('.level-header').each(function() {
        $(this).addClass('accept-drag');
        $(this).append('<i class="fa fa-arrows-h pull-right drag-icon"></i>');
      });

      $('#comp-table-show').dragtable({
        persistState: function(table) { 
          table.el.find('th[data-lvlid]').each(function(i) { 
              table.sortOrder[this.dataset.lvlid]=i;  
          }); 

          console.log("Sort order", table.sortOrder);

          var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

          $.ajaxSetup({
            headers: {
              'X-CSRF-Token': AUTH_TOKEN
            }
          });

          $.ajax({
            url: '/levels/order',
            method: "PUT",
            data: {
              order: table.sortOrder,
            },
              success: function(data) {
                console.log("Orden modificado exitosamente");
              }
          });
        }, 
        dragaccept:'.accept-drag',
      }); 

    } else{
      $('#toggle-drag').removeClass('active focus');

      $('.level-header').each(function() {
        $(this).removeClass('accept-drag');
      });

      $('.drag-icon').remove();
    }
  });
});