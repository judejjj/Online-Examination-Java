<%-- 
    Document   : adminlogin
    Created on : 17 Nov, 2020, 3:33:24 PM
    Author     : Abhay Shah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Database Connection Test
    String url = "jdbc:mysql://localhost:3306/ejproj?useSSL=false&allowPublicKeyRetrieval=true";
    String user = "root"; // Change if needed
    String password = ""; // Change if needed
    String dbStatus = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        dbStatus = "<p style='color:green; text-align:center;'>✅ Database Connected Successfully!</p>";
        conn.close();
    } catch (Exception e) {
        dbStatus = "<p style='color:red; text-align:center;'>❌ Database Connection Failed: " + e.getMessage() + "</p>";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        
        <title>OES | Login</title>
        <style>
           #logreg-forms{
                width:412px;
                margin:10vh auto;
                background-color:#f3f3f3;
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
                transition: all 0.3s cubic-bezier(.25,.8,.25,1);
            }
            #logreg-forms form {
                width: 100%;
                max-width: 410px;
                padding: 15px;
                margin: auto;
            }
            #logreg-forms .form-control {
                position: relative;
                box-sizing: border-box;
                height: auto;
                padding: 10px;
                font-size: 16px;
            }
            #logreg-forms input[type="submit"]{ margin-top:10px;  background-color: #4a4747 }
            #logreg-forms a{
                display: block;
                padding-top:10px;
                color:grey;
            }
            /* Mobile */
            @media screen and (max-width:500px){
                #logreg-forms{
                    width:300px;
                }
            }
        </style>
    </head>
    <body>
        <div id="logreg-forms">
            <form class="form-signin" action="adminlogin" method="POST">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Administrator Sign In</h1>
                <hr/>
                
                <!-- Database Connection Status -->
                <%= dbStatus %>

                <input type="email" class="form-control" placeholder="Email" required="" autofocus="" name="email" />
                <input type="password" class="form-control" placeholder="Password" required="" name="pass" /><br>
                
                <input class="btn btn-success btn-block" type="submit" value="Login" style="color:white;"><br/>
                <h5 style="color:red; text-align: center;">${err}</h5>
                <hr/>
            </form>
        </div>
    </body>
</html>
