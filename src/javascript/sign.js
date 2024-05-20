Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Ready", "");

function InitializeSignaturePad() {
  let canvas = document.createElement("canvas");
  canvas.id = "signbox";
  canvas.width = 700;
  canvas.height = 150;

  let submitButton = document.createElement("button");
  submitButton.id = "signDocument";
  submitButton.innerHTML = "Firmar Documento";

  let clearButton = document.createElement("button");
  clearButton.id = "Clear";
  clearButton.innerHTML = "Limpiar Firma";

  /*let DeleteButton = document.createElement("button");
  DeleteButton.id = "Delete";
  DeleteButton.innerHTML = "Delete Signature";*/


  let signatureLocation = document.getElementById("controlAddIn");

  signatureLocation.appendChild(canvas);
  signatureLocation.appendChild(submitButton);
  signatureLocation.appendChild(clearButton)
  //signatureLocation.appendChild(DeleteButton);

  var signaturePad = new SignaturePad(canvas, {
    backgroundColor: "rgb(255, 255, 255)",
  });

  clearButton.addEventListener("click", function(event)
  {
    signaturePad.clear();
  })

  /*deleteButton.addEventListener("click", function (event) {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Delete", "");
    signaturePad.clear();
  });*/

  submitButton.addEventListener("click", function (event) {
    if (signaturePad.isEmpty()) {
      alert("Por favor agregue una firma.");
    } else {
      var base64String = signaturePad.toDataURL();
      Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Sign",[base64String])
      signaturePad.clear();
    }
  });
  }