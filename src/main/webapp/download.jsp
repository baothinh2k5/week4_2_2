<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Downloads</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
    <style>
        /* CSS cho nút Logout và phần SQL */
        .logout-btn {
            float: right;
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 4px;
        }
        .sql-section {
            margin-top: 30px;
            border-top: 2px dashed #ccc;
            padding-top: 10px;
        }
        textarea {
            width: 100%;
            height: 60px;
            font-family: monospace;
        }
    </style>
</head>
<body>

    <a href="download?action=logout" class="logout-btn">Log Out</a>

    <c:set var="code" value="${sessionScope.productCode}" />
    <c:choose>
        <c:when test="${code == '8601'}">
            <c:set var="albumTitle" value="86 (the band) - True Life Songs and Pictures" />
            <c:set var="song1Title" value="You Are a Star" />
            <c:set var="song1File" value="star.mp3" />
            <c:set var="song2Title" value="Don't Make No Difference" />
            <c:set var="song2File" value="no_difference.mp3" />
        </c:when>
        <%-- ... (Các trường hợp khác giữ nguyên) ... --%>
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
            <td><a href="musicStore/sound/${code}/${song1File}" download>MP3</a></td>
        </tr>
        <tr>
            <td>${song2Title}</td>
            <td><a href="musicStore/sound/${code}/${song2File}" download>MP3</a></td>
        </tr>
    </table>

    <p><a href="download?action=viewAlbums">View list of albums</a></p>

    <div class="sql-section">
        <h3>Admin SQL Gateway</h3>
        <p>Enter an SQL statement and click Execute:</p>
        
        <form action="download" method="post">
            <input type="hidden" name="action" value="executeSql">
            
            <textarea name="sqlStatement"><c:out value="${sqlStatement}" default="SELECT * FROM users;"/></textarea>
            <br><br>
            <input type="submit" value="Execute SQL">
        </form>

        <c:if test="${not empty sqlResult}">
            <h4>SQL Result:</h4>
            <div>${sqlResult}</div>
        </c:if>
    </div>

</body>
</html>