<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Downloads</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>

    <c:set var="code" value="${sessionScope.productCode}" />

    <c:choose>
        <%-- Trường hợp 8601 --%>
        <c:when test="${code == '8601'}">
            <c:set var="albumTitle" value="86 (the band) - True Life Songs and Pictures" />
            <c:set var="song1Title" value="You Are a Star" />
            <c:set var="song1File" value="star.mp3" />
            <c:set var="song2Title" value="Don't Make No Difference" />
            <c:set var="song2File" value="no_difference.mp3" />
        </c:when>

        <%-- Trường hợp pf01 --%>
        <c:when test="${code == 'pf01'}">
            <c:set var="albumTitle" value="Paddlefoot - The First CD" />
            <c:set var="song1Title" value="Whiskey" />
            <c:set var="song1File" value="whiskey.mp3" />
            <c:set var="song2Title" value="Corvair" />
            <c:set var="song2File" value="corvair.mp3" />
        </c:when>

        <%-- Trường hợp pf02 --%>
        <c:when test="${code == 'pf02'}">
            <c:set var="albumTitle" value="Paddlefoot - The Second CD" />
            <c:set var="song1Title" value="Neon" />
            <c:set var="song1File" value="neon.mp3" />
            <c:set var="song2Title" value="Tank" />
            <c:set var="song2File" value="tank.mp3" />
        </c:when>

        <%-- Trường hợp jr01 --%>
        <c:when test="${code == 'jr01'}">
            <c:set var="albumTitle" value="Joe Rut - Genuine Wood Grained Finish" />
            <c:set var="song1Title" value="Filter" />
            <c:set var="song1File" value="filter.mp3" />
            <c:set var="song2Title" value="So Long" />
            <c:set var="song2File" value="so_long.mp3" />
        </c:when>

        <%-- Mặc định --%>
        <c:otherwise>
            <c:set var="albumTitle" value="Unknown Album" />
            <c:set var="song1Title" value="Unknown" />
            <c:set var="song1File" value="#" />
            <c:set var="song2Title" value="Unknown" />
            <c:set var="song2File" value="#" />
        </c:otherwise>
    </c:choose>

    <h1>Downloads</h1>
    
    <h2>${albumTitle}</h2>

    <table>
        <tr>
            <th>Song title</th>
            <th>Audio Format</th>
        </tr>
        <tr>
            <td>${song1Title}</td>
            <td>
                <a href="musicStore/sound/${code}/${song1File}" download>MP3</a>
            </td>
        </tr>
        <tr>
            <td>${song2Title}</td>
            <td>
                <a href="musicStore/sound/${code}/${song2File}" download>MP3</a>
            </td>
        </tr>
    </table>

    <p><a href="download?action=viewAlbums">View list of albums</a></p>
    
</body>
</html>