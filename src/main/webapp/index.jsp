<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="paw.png">
    <!-- CSS only -->
    <title>Conexão BD</title>
    <style>
        table,td{
            border:1px solid black;
            border-collapse: collapse;
        }
    </style>
</head>
<body style="border-color: lavenderblush">
<%
//acesso ao banco de dados
Connection conexaoBD = null;
PreparedStatement cmdSQL = null;
ResultSet rsGato = null;
String banco,usuario,senha;
//Dados
String nome,cor,sexo,raca,lugarCarinho;
//Conexao BD
try{
    banco="jdbc:mysql://localhost/GatoDB";
    usuario="root";
    senha="sarahmiguel2";
    Class.forName("com.mysql.jdbc.Driver");
    conexaoBD = DriverManager.getConnection(banco,usuario,senha);
}catch (Exception e){
    out.println("<h3> Ocorreu um erro:"+e.getMessage()+"</h3>");
    return;
}
//Selecionar operacao
String operacao;
operacao="SELECIONAR";
if(operacao=="INSERIR"){
    try{
        nome="";
        cor="";
        raca="";
        sexo="";
        lugarCarinho="";
        cmdSQL=conexaoBD.prepareStatement("INSERT INTO gato(nome,cor,sexo,raca,lugarCarinho) VALUES"+
                                        "('"+nome+"','"+cor+"','"+sexo+"','"+raca+"','"+lugarCarinho+"')");
        cmdSQL.executeUpdate();
        out.println("Você inseriu com suscesso um gato na tabela! :)");
    }catch (Exception e){
        out.println("<h3> Ocorreu um erro:"+e.getMessage()+"</h3>");
        return;
    }

}
else if(operacao=="SELECIONAR"){
    try{
        cmdSQL=conexaoBD.prepareStatement("SELECT * FROM gato");
        rsGato=cmdSQL.executeQuery();
        if(rsGato.next()){
            out.println("<table style='border:1px solid black;'>");
            out.println("<tr>");
            out.println("   <td>NOME</td>");
            out.println("   <td>COR</td>");
            out.println("   <td>SEXO</td>");
            out.println("   <td>RAÇA</td>");
            out.println("   <td>LUGAR FAVORITO DE CARINHO</td>");
            out.println("<tr>");
            do{
                nome=rsGato.getString("nome");
                cor=rsGato.getString("cor");
                sexo=rsGato.getString("sexo");
                raca=rsGato.getString("raca");
                lugarCarinho=rsGato.getString("lugarCarinho");
                out.println("<tr>");
                out.println("   <td>"+nome+"</td>");
                out.println("   <td>"+cor+"</td>");
                out.println("   <td>"+sexo+"</td>");
                out.println("   <td>"+raca+"</td>");
                out.println("   <td>"+lugarCarinho+"</td>");
                out.println("</tr>");
            }while (rsGato.next());
            out.println("</table>");
        }else{
            out.println("<h3>SEM DADOS CADASTRADOS</h3>");
        }
    }catch (Exception e){
        out.println("<h3> Ocorreu um erro:"+e.getMessage()+"</h3>");
        return;
    }

}
else if(operacao=="ALTERAR"){
    try{
        nome="";
        cor="";
        raca="";
        sexo="";
        lugarCarinho="";
        cmdSQL=conexaoBD.prepareStatement("UPDATE gato SET cor = '"+cor+"', sexo='"+sexo+"', raca='"+raca+"', lugarCarinho='"+lugarCarinho+"' WHERE nome='"+nome+"'");
        cmdSQL.executeUpdate();
        out.println("Alteração feita com suscesso! :)");
    }catch (Exception e){
        out.println("<h3> Ocorreu um erro:"+e.getMessage()+"</h3>");
        return;
    }
}
else if(operacao=="EXCLUIR"){
    try{
        nome="";
        cmdSQL=conexaoBD.prepareStatement("DELETE FROM gato WHERE nome='"+nome+"'");
        cmdSQL.executeUpdate();
        out.println("Você excluiu com suscesso um gato na tabela! :(");
    }catch (Exception e){
        out.println("<h3> Ocorreu um erro:"+e.getMessage()+"</h3>");
        return;
    }
}
conexaoBD.close();
%>
</body>
</html>