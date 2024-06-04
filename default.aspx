<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Monitorizar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group input[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
            text-align: center;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            box-sizing: border-box;
        }

        .output {
            margin-top: 20px;
            background-color: #f9f9f9;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Monitorizar</h1>
        <form id="cmd" method="GET" runat="server">
            <div class="form-group">
                <label for="ipAddress">Dirección IP:</label>
                <input type="text" id="ipAddress" name="ipAddress" placeholder="Introduce la dirección IP">
            </div>
            <div class="form-group">
                <input type="submit" value="Hacer Ping">
            </div>
        </form>
        <div class="output">
            <% 
            string resultado = string.Empty;

            if (!string.IsNullOrEmpty(Request.QueryString["ipAddress"]))
            {
                string ipAddress = Request.QueryString["ipAddress"];
                resultado = ExecuteCmd(ipAddress);
                resultado = Server.HtmlEncode(resultado).Replace("\r\n", "<br>");
            }

            %>
            <pre><%= resultado %></pre>
        </div>
    </div>
</body>
</html>

<script runat="server">
    string ExecuteCmd(string ipAddress)
    {
        ProcessStartInfo valores = new ProcessStartInfo();
        valores.FileName = "powershell.exe";
        valores.Arguments = $"ping -n 2 {ipAddress}";
        valores.RedirectStandardOutput = true;
        valores.UseShellExecute = false;
        Process proceso = Process.Start(valores);
        StreamReader lector = proceso.StandardOutput;
        string salida = lector.ReadToEnd();
        lector.Close();
        return salida;
    }
</script>
