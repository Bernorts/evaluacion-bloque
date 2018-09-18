// append row to the HTML table
function appendRow() {
    var tbl = document.getElementById('my-table'), // table reference
        row = tbl.insertRow(tbl.rows.length-1),      // append table row
        i;
    // insert table cells to the new row
        createCell(row.insertCell(0), 'textarea', 'form-control', 'firstCol', 'Descripción');
    for (i = 1; i < tbl.rows[0].cells.length-1; i++) {
        createCell(row.insertCell(i), 'textarea', 'form-control', '', 'Descripción');
    }
}
 
// create DIV element and append to the table cell
function createCell(cell, text, style, extra, placeholder) {
    var div = document.createElement('div'), // create DIV element
        txt = document.createElement(text);
    if(text == 'input'){
      txt.type = "text"
    }
    if(extra == 'firstCol'){
      var ex = document.createElement('input')
      ex.type = 'text'
      ex.setAttribute('class', style);        // set DIV class attribute
      ex.setAttribute('placeholder', 'Nombre')
      div.appendChild(ex)
    }
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
    createCell(tbl.rows[0].insertCell(tbl.rows[0].cells.length-1), 'input', 'form-control', '', 'Nombre');
    for (i = 1; i < tbl.rows.length-1; i++) {
        createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length-1), 'textarea', 'form-control', '', 'Descripción');
    }
}

// // delete table rows with index greater then 0
// function deleteRows() {
//     var tbl = document.getElementById('my-table'), // table reference
//         lastRow = tbl.rows.length - 1,             // set the last row index
//         i;
//     // delete rows with index greater then 0
//     for (i = lastRow; i > 0; i--) {
//         tbl.deleteRow(i);
//     }
// }
 
// // delete table columns with index greater then 0
// function deleteColumns() {
//     var tbl = document.getElementById('my-table'), // table reference
//         lastCol = tbl.rows[0].cells.length - 1,    // set the last column index
//         i, j;
//     // delete cells with index greater then 0 (for each row)
//     for (i = 0; i < tbl.rows.length; i++) {
//         for (j = lastCol; j > 0; j--) {
//             tbl.rows[i].deleteCell(j);
//         }
//     }
// }