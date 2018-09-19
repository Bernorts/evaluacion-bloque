// append row to the HTML table
var countR = 0, countC = 0;
function appendRow() {
    var tbl = document.getElementById('my-table'), // table reference
        row = tbl.insertRow(tbl.rows.length-1),      // append table row
        i;
    // insert table cells to the new row
    row.id = 'addedrow' + countR;
    createCell(row.insertCell(0), 'textarea', 'form-control', 'firstCol', 'Descripción', 'new_competences_descriptions[' + countR + ']');
    createCell(row.insertCell(1), 'textarea', 'form-control', 'evidences', 'Evidencias', 'new_competences_evidences[' + countR + ']');
    for (i = 2; i < tbl.rows[0].cells.length-1; i++) {
        createCell(row.insertCell(i), 'textarea', 'form-control', '', 'Descripción', 'new_competences_levels[' + countR + ',' + i + ']');
    }
    createCell(row.insertCell(i), 'button', 'btn btn-warning', 'deleteRow', countR, '');
    countR += 1;
}
 
// create DIV element and append to the table cell
function createCell(cell, text, style, extra, placeholder, name) {
    var div = document.createElement('div'), // create DIV element
        txt = document.createElement(text);
    if(text == 'input'){
      txt.type = "text"
    }
    if(text == 'button'){
        if(extra == 'deleteColumn'){
            cell.id = 'addedcol' + placeholder;
        }
        txt.setAttribute('onclick', extra + '(' + placeholder + ', "added")')
        txt.type = "button"
        txt.innerHTML = '-'
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
    var tbl = document.getElementById('my-table'), // table reference
        i;
    // open loop for each row and append cell
    createCell(tbl.rows[0].insertCell(tbl.rows[0].cells.length-1), 'input', 'form-control', '', 'Nombre', 'new_levels_names[' + countC + ']');
    for (i = 1; i < tbl.rows.length-1; i++) {
        createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length-1), 'textarea', 'form-control', '', 'Descripción', 'new_levels_competences[' + countC + ',' + i + ']');
    }
    countC += 1;
    createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), 'button', 'btn btn-warning', 'deleteColumn', countC, '');
}

function deleteRow(id, extra) {
    var tbl = document.getElementById('my-table'), // table reference
    index = document.getElementById(extra + 'row' + id);
    tbl.deleteRow(index.rowIndex);
}
 
function deleteColumn(id, extra) {
    var tbl = document.getElementById('my-table'), // table reference
        lastCol = tbl.rows[0].cells.length - 1,    // set the last column index
        index = document.getElementById(extra + 'col' + id), i;
    // delete cells with index greater then 0 (for each row)
    for (i = 0; i < tbl.rows.length; i++) {
        tbl.rows[i].deleteCell(index.cellIndex);
    }
}