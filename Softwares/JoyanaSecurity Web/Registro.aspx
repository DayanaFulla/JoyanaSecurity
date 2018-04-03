<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Registro.aspx.cs" Inherits="Registrar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.0.17/webcomponents-lite.js"></script>
    <link rel="import" href="https://raw-dot-custom-elements.appspot.com/GoogleWebComponents/google-map/v2.0.2/google-map/google-map.html" />

    <style>
        google-map {
            height: 380px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form class="container" runat="server">
        <div class="container">            
            <div class="col-md-7  col-md-offset-2" style="background-color: white; border-radius: 10px; border: 2px solid #989797; margin-bottom: 20px; margin-top: 20px; padding-left: 30px; padding-right: 30px;">
                <div class="form-group">
                    <h3 class="text-center">Registro de Producto</h3>
                </div>

                <div class="form-group">
                    <h4 class="text-muted">Datos de Usuario</h4>
                </div>

                <div class="form-group">
                    <asp:Label ID="Label9" runat="server" Text="Nombre Completo: " Font-Bold="true"></asp:Label><br />
                    <asp:TextBox ID="txtNombreComp" runat="server" CssClass="form-control" placeholder="Ingrese su Nombre Completo"></asp:TextBox>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col col-md-6">
                            <asp:Label ID="Label1" runat="server" Text="Teléfono: " Font-Bold="true" ></asp:Label><br />
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ingrese su Teléfono"></asp:TextBox>
                        </div>
                        <div class="col col-md-6">
                            <asp:Label ID="Label2" runat="server" Text="Email" Font-Bold="true"></asp:Label><br />
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Ingrese su Email" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col col-md-6">
                            <asp:Label ID="Label3" runat="server" Text="Contraseña" Font-Bold="true"></asp:Label><br />
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su Contraseña"></asp:TextBox>
                        </div>
                        <div class="col col-md-6">
                            <asp:Label ID="Label4" runat="server" Text="Repita Contraseña" Font-Bold="true"></asp:Label><br />
                            <asp:TextBox ID="txtRePassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su Contraseña"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="Label8" runat="server" Text="Dirección" Font-Bold="true"></asp:Label><br />
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" placeholder="Ingrese su Dirección"></asp:TextBox>
                </div>

                <div class="form-group">
                    <h4 class="text-muted">Datos de Alarma</h4>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col col-md-6">
                            <asp:Label ID="Label5" runat="server" Text="Contraseña de Activación" Font-Bold="true"></asp:Label><br />
                            <asp:TextBox ID="txtAlarmPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su Contraseña de Activación"></asp:TextBox>
                        </div>
                        <div class="col col-md-6">
                            <asp:Label ID="Label6" runat="server" Text="Repita su Contraseña de Activación" Font-Bold="true"></asp:Label><br />
                            <asp:TextBox ID="txtReAlarmPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su Contraseña de Activación"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="Label7" runat="server" Text="Seleccione donde estará ubicada su Alarma en el siguiente Mapa: " Font-Bold="true"></asp:Label>
                    <br />
                    <google-map latitude="-17.7979877" longitude="-63.1478128" zoom="15" fit-to-markers api-key="AIzaSyD3E1D9b-Z7ekrT3tbhl_dy8DCXuIuDDRc" id="Gmap">
                         <google-map-marker id="markerG" latitude="-17.7979877" longitude="-63.1478128" draggable="true"></google-map-marker>
                    </google-map>

                </div>
                <br />
                <asp:Label ID="lbValidator" runat="server" Text="" ForeColor="Red"></asp:Label>
                <div class="form-group" style="display: flex; align-items: center; justify-content: center; margin-bottom: 30px">
                    <asp:Button ID="btnGuardar" runat="server" Text="REGISTRAR" OnClientClick="prueba()" OnClick="btnGuardar_Click" CssClass="btn btn-primary btn-block" />
                </div>                
            </div>    
                    
            <asp:HiddenField ID="longitudHidden" runat="server" />
            <asp:HiddenField ID="latitudHidden" runat="server" />            
        </div>

    </form>

    <script>
        function prueba() {
            var marker = document.getElementById("markerG");
            //console.log(marker.latitud);
            //alert("lat: " + marker.latitude + " - long: " + marker.longitude)            
            document.getElementById("<%=latitudHidden.ClientID%>").value = marker.latitude;
            document.getElementById("<%=longitudHidden.ClientID%>").value = marker.longitude;

        }
    </script>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="~/Style/js/jquery-3.2.1.min.js"></script>
</asp:Content>

