<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
  <h3>Login</h3>
  <form action="/webapp-jdbc/login" method="post">

    <div>
      <label for="username">Username</label>
      <div>
        <input autofocus type="text" name="username" id="username">
      </div>
    </div>

    <div>
      <label for="password">Password</label>
      <div>
        <input type="password" name="password" id="password">
      </div>
    </div>

    <div>
      <input type="submit" value="Ingresar">
    </div>

  </form>
  <p><a href="/webapp-jdbc/index.html">Volver</a></p>
</body>
</html>