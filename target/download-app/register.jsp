<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>

    <h1>Download registration</h1>
    
    <p>To register for our downloads, enter your name and email address below. 
       Then, click on the Submit button.</p>

    <form action="download" method="post">
        <input type="hidden" name="action" value="registerUser">
        
        <label>Email:</label>
        <input type="email" name="email" value="" required><br>
        
        <label>First Name:</label>
        <input type="text" name="firstName" value="" required><br>
        
        <label>Last Name:</label>
        <input type="text" name="lastName" value="" required><br>
        
        <input type="submit" value="Register">
    </form>

</body>
</html>