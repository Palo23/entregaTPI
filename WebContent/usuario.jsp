<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
              	HttpSession sesionNueva = request.getSession();
    			int roles = (int)sesionNueva.getAttribute("role");
    			String usuario = (String) sesionNueva.getAttribute("usuario");
    			String nombre = (String) sesionNueva.getAttribute("nombreUser");
    			String apellido = (String) sesionNueva.getAttribute("apellido");
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
        <!-- Iconos externos para estilos 
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">-->
        <link rel="stylesheet" href="CSS2/colores.css" type="text/css">
        <link rel="stylesheet" href="CSS2/margenes.css" type="text/css">
        <script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    </head>
    <body style="background-image: url('Images/fondo1.jpg');">
      
      <nav>
        <div class="nav-wrapper">
                <a href="home.jsp" class="brand-logo"><img class="responsive-image" src="Images/logo3.png"></a>
          <ul id="nav-mobile" class="right hide-on-med-and-down">
            <li><a href="cerrarsesion.jsp"><%=nombre + " "%><%=apellido%> (Cerrar Sesión)</a></li>
          </ul>
        </div>
      </nav>
            
        <div class="ventana3">
        		<a href="Usuario?action=new" class="waves-effect waves-light btn-small brown">Agregar Usuario</a>
                <h5 class="bienvenido3">Tabla de contenido</h5>
                <table class="tabla">
                    <thead>
                      <tr>
                          <th class="btns">Nombre</th>
                          <th class="btns">Apellido</th>
                          <th class="btns">ID</th>
                          <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
    
                <!--   for (Todo todo: todos) {  -->
              <c:forEach var="user" items="${listUser}">
    
                <tr>
                  <td><c:out value="${user.nombre}" /></td>
                  <td><c:out value="${user.apellido}" /></td>
                  <td><c:out value="${user.id}" /></td>
                  <td>
                    <a class="waves-effect waves-light btn-small brown" href="edit?id=<c:out value='${user.id}' />">Editar</a>
                    <a class="waves-effect waves-light btn-small brown modal-trigger" href="#<c:out value='${user.id}'/>">Eliminar</a>
                  </td>					 
                                     <!-- Modal Structure -->
                        <div id="<c:out value='${user.id}'/>" class="modal">
                          <div class="modal-content">
                              <h4>Confirmar</h4>
                              <h5>¿Deseás eliminar al usuario <c:out value='${user.nombre}'/> <c:out value='${user.apellido}'/>?</h5>
                          </div>
                        <div class="modal-footer">
                            <a href="delete?id=<c:out value='${user.id}' />" class="modal-close waves-effect waves-green btn-flat">Eliminar</a>
                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                        </div>
                                          </div>
                                    
        
                </tr>
              </c:forEach>
              <!-- } -->
                    </tbody>
                  </table>
                  
        </div>
    
        <footer class="pie3">
            <!-- Disclaimer de la pagina -->
                <p>
                    <h5>SysInvent - Todos los derechos reservados - Año 2020 </h5>
                </p> 
            </footer>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js">
            </script>
            <script>
              $(document).ready(function(){
                $('.modal').modal();
                });
            </script>
    
    </body>
    </html>