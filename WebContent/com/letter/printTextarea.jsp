<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Print Content</title>
</head>
<body>
    <div id="content"></div>
    <script>
        var editorContent = window.opener.CKEDITOR.instances['message'].getData();
        document.getElementById('content').innerHTML = editorContent;
        window.print();
    </script>
</body>
</html>