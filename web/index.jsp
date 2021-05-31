<%-- 
    Document   : index
    Created on : 31 de mai. de 2021, 17:05:57
    Author     : Fernanda
--%>

<%@page import="web.DbListener"%>
<%@page import="db.TasksConnector"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Exception reqException = null;
    ArrayList<String> taskList = new ArrayList<>();
    try{
        if(request.getParameter("add")!=null){
            String taskName = request.getParameter("taskName");
            TasksConnector.addTask(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        if(request.getParameter("remove")!=null){
            String taskName = request.getParameter("taskName");
            TasksConnector.removeTask(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        taskList = TasksConnector.getTasks();
    }catch(Exception ex){
        reqException = ex;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tarefas - JDBC</title>
    </head>
    <body>
        <h1>JDBC</h1>
        <h1>Jane Fernanda Martins</h1>
        <h2>RA: 1290481812013</h2>
        <%if(DbListener.exception != null){%>
        <div style="color:red">
            Erro na criação da base: <%= DbListener.exception.getMessage() %>
        </div>
        <hr/>
        <%}%>
        <%if(reqException != null){%>
        <div style="color:red">
            Erro no processamento da página: <%= reqException.getMessage() %>
        </div>
        <hr/>
        <%}%>
        <h2>Tarefas</h2>
        <form>
            <input type="text" name="taskName"/>
            <input type="submit" name="add" value="Adicionar"/>
        </form>
        <hr/>
        <table>
            <tr>
                <th>Nome da tarefa</th>
                <th>Excluir</th>
            </tr>
            <%for(String taskName: taskList){%>
            <tr>
                <td><%= taskName %></td>
                <td>
                    <form>
                        <input type="hidden" name="taskName" value="<%= taskName %>"/>
                        <input type="submit" name="remove" value="Excluir"/>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
