<%@page contentType="UTF-8" import="java.util.*, webapp.models.* "%>
<%
  List<Producto> productos = (List<Producto>) request.getAttribute("productos");
  Optional<String> username = (Optional<String>) request.getAttribute("username");

  // Obtener valores de los listeners
  String mensajeRequest = (String) request.getAttribute("mensaje"); // Mensaje del request
  String mensajeApp = (String) getServletContext().getAttribute("mensaje"); // Mensaje global
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Listado de productos</title>
</head>
<body>
    <h1>Listado de productos</h1>
    <% if (username.isPresent()) { %>
    <h3>Bienvenido <%=username.get()%>!</h3>
    <p><a href="<%=request.getContextPath()%>/productos/form">Crear producto</a></p>
    <% } %>
    <table>
        <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Categoria</th>
            <% if (username.isPresent()) { %>
                <th>Precio</th>
                <th>Agregar</th>
                <th>Editar</th>
                <th>Eliminar</th>
            <% } %>
        </tr>
        <% for(Producto p : productos) { %>
        <tr>
            <td><%=p.getId()%></td>
            <td><%=p.getNombre()%></td>
            <td><%=p.getCategoria().getNombre()%></td>
            <% if (username.isPresent()) { %>
                <td><%=p.getPrecio()%></td>
                <td><a href="<%=request.getContextPath()%>/carro/agregar?id=<%=p.getId()%>">Agregar al carro</a></td>
                <td><a href="<%=request.getContextPath()%>/productos/form?id=<%=p.getId()%>">Editar</a></td>
                <td><a onclick="return confirm('Esta seguro que desea eliminar?');"
                href="<%=request.getContextPath()%>/productos/eliminar?id=<%=p.getId()%>">Eliminar</a></td>
            <% } %>
        </tr>
        <% } %>
    </table>
    <p><%=mensajeApp%></p>
    <p><%=mensajeRequest%></p>
    <p><a href="<%=request.getContextPath()%>/index.html">Volver</a><p/>
</body>
</html>