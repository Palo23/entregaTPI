<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <%
              	HttpSession sesionNueva = request.getSession();
          int roles = (int)sesionNueva.getAttribute("role");
          int idUser = (int)sesionNueva.getAttribute("idUser");
    			String usuario = (String) sesionNueva.getAttribute("usuario");
    			String nombre = (String) sesionNueva.getAttribute("nombreUser");
    			String apellido = (String) sesionNueva.getAttribute("apellido");
    			int empresa = (int)sesionNueva.getAttribute("empresa");
    %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <title>SysInvent</title>
        <!-- Hoja externa de estilos materialize 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"> -->
        <link rel="stylesheet" href="materialize-v1.0.0/materialize/css/materialize.css">
        <!-- Iconos externos para estilos -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="CSS2/colores.css" type="text/css">
        <link rel="stylesheet" href="CSS2/margenes.css" type="text/css">
        <script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    </head>

    <body style="background-image: url('Images/fondo1.jpg');">
        <div class="navbar-fixed">
        <nav>
            
            <div class="nav-wrapper">
                <a href="home.jsp" class="brand-logo"><img class="responsive-image" src="Images/logo3.png"></a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li>
                        <a href="cerrarsesion.jsp">
                            <%=nombre + " "%>
                                <%=apellido%> (Cerrar Sesión)</a>
                    </li>
                </ul>
            </div>
       
        </nav>
    </div>
        <div class="ventana4 col s12 m6">
        <!-- Si el usuario es admin o inventarista puede ver los invantarios de todas las empresas -->
            <% if(roles == 1 || roles == 2){ %>
                <div class="row col s12 m6" style="width: 643px; top: 15%; position:relative;">
                    <form action="Inventario?action=all" method="POST">
                        <select id="idEmpresa" name="idEmpresa" class="browser-default" onchange="this.form.submit()" style="width: 50%; float: left;">
               <option value="" disabled selected>-- Selecciona la empresa --</option>
               <c:forEach var="emp" items="${listEmpresa}">
            <option value="${emp.id}">${emp.nombre}</option>
            </c:forEach>
           </select>
                    </form>
                    <a href="Inventario?action=new" class="btn-floating btn-large btn tooltipped waves-effect brown" 
                    style="float: right;" data-position="bottom" data-tooltip="Agregar producto"><i class="material-icons">add</i></a>
                </div>
                <% } %>
                    <c:if test="${nombreEmpresa != null}">
                        <h5 class="bienvenido4">Inventario de
                            <c:out value="${nombreEmpresa.nombre}"></c:out>
                        </h5>
                    </c:if>
                    <c:if test="${nombreEmpresa == null}">
                        <h5 class="bienvenido4">Tabla de contenido</h5>
                    </c:if>
                    <table class="tabla2 col s12 m6">
                        <thead>
                            <tr style="width: 100%;">
                                <th class="btns2">Código</th>
                                <th class="btns2">Nombre</th>
                                <th class="btns2">Empresa</th>
                                <th class="btns2">Cantidad</th>
                                <th class="btns2">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(roles == 1 || roles == 2){ %>
                            <!-- Recorremos los productos en inventario -->
                                <c:if test="${listProduct != null}">
                                    <c:forEach var="prod" items="${listProduct}">
                                        <tr style="width: 100%;">
                                            <td class="btns2">${prod.id}</td>
                                            <td class="btns2">${prod.nombre}</td>
                                            <td class="btns2">${prod.nombreEmpresa}</td>
                                            <td class="btns2">${prod.cantidad}</td>
                                            <td class="btns2"><a href="#<c:out value='${prod.id}'/>" 
                                            class="btn-floating btn-small btn tooltipped waves-effect brown modal-trigger" data-position="bottom" data-tooltip="Editar producto"><i class="material-icons">edit</i></a></td>
                                        </tr>
                                        
                                        <!-- Modal para registro de entradas/salidas -->
                                        <div id="<c:out value='${prod.id}'/>" class="modal col s12 m6" style="top: -25%; width: 80%;">
                                            <div class="modal-content col s12 m6">
                                                <input type="text" value="<c:out value='${nombreEmpresa.nombre}'/>" disabled>
                                                <form id="registrarForm<c:out value='${prod.id}'/>" action="Inventario?action=updateCant" method="POST">
                                                    <input type="hidden" id="empresaRecarga<c:out value='${prod.id}'/>" name="empresaRecarga" value="<c:out value='${nombreEmpresa.id}'/>">
                                                    <input id="userYo<c:out value='${prod.id}'/>" name="userYo" type="hidden" value="<%=idUser%>">
                                                    <input id="productoID<c:out value='${prod.id}'/>" name="productoID" type="hidden" value="<c:out value='${prod.id}'/>">
                                                    <select id="movimiento<c:out value='${prod.id}'/>" name="movimiento" class="browser-default" style="width: 80%;">
                                                                  <option value="" disabled selected>-- Tipo de movimiento --</option>
                                                                  <option value="1">Entrada</option>
                                                                  <option value="2">Salida</option>
                                                            </select>
                                                    <select id="userExt<c:out value='${prod.id}'/>" name="userExt" class="browser-default" style="width: 80%;">
                                                                  <option value="" disabled selected>-- Usuario externo encargado --</option>
                                                                  <c:forEach var="user" items="${listUsers}">
                                                                    <option value="${user.id}">${user.nombre}</option>
                                                                  </c:forEach>
                                                            </select>
                                                    <input id="cantidad<c:out value='${prod.id}'/>" name="cantidad" type="number" placeholder="Cantidad que entra/sale">
                                                    <label>Producto disponible</label>
                                                    <input id="disponible<c:out value='${prod.id}'/>" name="disponible" value="<c:out value='${prod.cantidad}'/>" disabled>
                                                    <div class="modal-footer col s12 m6">
                                                        <button onclick="comprobar(<c:out value='${prod.id}'/>)" class="modal-close waves-effect waves-green btn-flat">Registrar</button>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>


                                        </th>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${listProduct == null}">
                                <br><br><br>
                                    <h5 class="bienvenido6">No has seleccionado ninguna empresa</h5>
                                </c:if>
                                <% }else if(roles == 3){ %>
                                <!-- Si es rol externo solo puede ver el inventario de su propia empresa -->
                                    <c:if test="${nombreEmpresa.id == empresa }">
                                        <c:forEach var="prod" items="${listProduct}">
                                            <tr>
                                                <td class="btns2">${prod.id}</td>
                                                <td class="btns2">${prod.nombre}</td>
                                                <td class="btns2">${prod.nombreEmpresa}</td>
                                                <td class="btns2">${prod.cantidad}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${nombreEmpresa.id != empresa }">
                                    <br><br><br>
                                        <h5 class="bienvenido6">Esta página no puede ser mostrada</h5>
                                    </c:if>
                                    <% } %>
                        </tbody>
                    </table>

        </div>

        <footer class="pie3 col s12 m6">
            <!-- Disclaimer de la pagina -->
            <p>    
            <h5>SysInvent - Todos los derechos reservados - Año 2020 </h5>
            </p>
        </footer>
        <script>
            $(document).ready(function(){
                $('.tooltipped').tooltip();
            });
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script>
            $(document).ready(function() {
                $('.modal').modal();
            });
            
            function comprobar(idjs) {
                event.preventDefault()
                idProd = idjs
                cantidadActual = parseInt(document.getElementById('disponible'+idProd).value, 10)
                accion = document.getElementById('movimiento'+idProd).value
                usuario = document.getElementById('userExt'+idProd).value
                cantidadModificar = parseInt(document.getElementById('cantidad'+idProd).value, 10)

                //Se debe seleccionar un usuario encargado para realizar una modificación en inventario
                if (usuario == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Debes seleccionar un usuario',
                    })
                } else {
                    //Si es una entrada
                    if (accion == 1) {
                        if (cantidadModificar <= 0) {
                            //No se pueden ingresar 0 o valores negativos
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'No puedes ingresar valores menores a 0',
                            })
                        } else if (cantidadModificar > 0) {
                            //Si es entrada y la cantidad es mayor a cero se registra
                            //console.log(cantidadActual, accion, usuario, cantidadModificar)
                            document.getElementById('registrarForm'+idProd).submit();
                        }
                    } else if (accion == 2) {
                        //Si es salida
                        if (cantidadModificar > cantidadActual) {
                            //Si se intenta sacar del inventario una cantidad mayor a la existente genera un error
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'La existencia en inventario no es suficiente',
                            })
                        } else if (cantidadModificar <= 0) {
                            //No se pueden sacar del inventario valores negativos
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'No puedes ingresar valores menores a 0',
                            })
                        } else if (cantidadModificar > 0 && cantidadModificar < cantidadActual) {
                            //Si se cumplen las condiciones se registra
                            //console.log(cantidadActual, accion, usuario, cantidadModificar)
                            document.getElementById('registrarForm'+idProd).submit();
                        }
                    } else if (accion == "") {
                        //Si no se selecciona entre entrada y salida generará un error
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Debes seleccionar el tipo de movimiento',
                        })
                    }
                }



            }
        </script>

    </body>


    </html>