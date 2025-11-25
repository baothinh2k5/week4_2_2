<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>

    <%
        // 1. L?y mã s?n ph?m t? Session
        String productCode = (String) session.getAttribute("productCode");
        
        // 2. Khai báo bi?n ?? l?u thông tin bài hát
        String albumTitle = "Unknown Album";
        String song1Title = "";
        String song1File = "";
        String song2Title = "";
        String song2File = "";

        // 3. Ki?m tra mã s?n ph?m và gán tên file chính xác theo hình ?nh c?a b?n
        if ("8601".equals(productCode)) {
            albumTitle = "86 (the band) - True Life Songs and Pictures";
            song1Title = "You Are a Star";
            song1File = "star.mp3";
            song2Title = "Don't Make No Difference";
            song2File = "no_difference.mp3";
        } 
        else if ("pf01".equals(productCode)) {
            albumTitle = "Paddlefoot - The First CD";
            song1Title = "Whiskey";
            song1File = "whiskey.mp3";
            song2Title = "Corvair";
            song2File = "corvair.mp3";
        } 
        else if ("pf02".equals(productCode)) {
            albumTitle = "Paddlefoot - The Second CD";
            song1Title = "Neon";
            song1File = "neon.mp3";
            song2Title = "Tank";
            song2File = "tank.mp3";
        } 
        else if ("jr01".equals(productCode)) {
            albumTitle = "Joe Rut - Genuine Wood Grained Finish";
            song1Title = "Filter";
            song1File = "filter.mp3";
            song2Title = "So Long";
            song2File = "so_long.mp3";
        }
    %>

    <h1>Downloads</h1>
    
    <h2><%= albumTitle %></h2>

    <table>
        <tr>
            <th>Song title</th>
            <th>Audio Format</th>
        </tr>
        <tr>
            <td><%= song1Title %></td>
            <td>
                <a href="musicStore/sound/<%= productCode %>/<%= song1File %>" download>MP3</a>
            </td>
        </tr>
        <tr>
            <td><%= song2Title %></td>
            <td>
                <a href="musicStore/sound/<%= productCode %>/<%= song2File %>" download>MP3</a>
            </td>
        </tr>
    </table>

    <p><a href="download?action=viewAlbums">View list of albums</a></p>
    
</body>
</html>