Imports System.Data
Imports System.Data.SqlClient
'Imports System.Configuration
Imports System.Web.Services
Imports System.Web.Configuration
'Imports System.Web.Script.Serialization
Imports System.IO
Imports System.Security.Cryptography
'Imports System.Threading
Imports System.Net
Imports System.Net.Mail
'Imports System.Net.Mime

Partial Class appGetData

    Inherits System.Web.UI.Page

    Public Shared Function dbOpen(db As String) As SqlConnection
        Dim ConnectDB As New SqlConnection(WebConfigurationManager.ConnectionStrings(db).ConnectionString)
        Return ConnectDB
    End Function

    Public Shared Function dbClose(command As SqlCommand, connect As SqlConnection) As Int16
        command.Connection.Close()
        command.Connection.Dispose()

        connect.Close()
        connect.Dispose()
        SqlConnection.ClearPool(connect)

        Return 0

    End Function

    Public Shared Function getString(storeProcedure As String, servizio As Integer, db As String) As SqlDataReader
        Dim SQLConnect As SqlConnection = dbOpen(db)

        Dim dataCommand As New SqlCommand(storeProcedure, SQLConnect)
        dataCommand.CommandType = CommandType.StoredProcedure
        dataCommand.Parameters.AddWithValue("@idSer", servizio)
        SQLConnect.Open()

        Dim dataReader As SqlDataReader = dataCommand.ExecuteReader()

        Return dataReader

        dbClose(dataCommand, SQLConnect)

    End Function

    'Encrypting a string
    Public Shared Function passwordEncrypt(ByVal inText As String, ByVal key As String) As String
        Dim bytesBuff As Byte() = Encoding.Unicode.GetBytes(inText)
        Using aes__1 As Aes = Aes.Create()
            Dim crypto As New Rfc2898DeriveBytes(key, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D,
             &H65, &H64, &H76, &H65, &H64, &H65,
             &H76})
            aes__1.Key = crypto.GetBytes(32)
            aes__1.IV = crypto.GetBytes(16)
            Using mStream As New MemoryStream()
                Using cStream As New CryptoStream(mStream, aes__1.CreateEncryptor(), CryptoStreamMode.Write)
                    cStream.Write(bytesBuff, 0, bytesBuff.Length)
                    cStream.Close()
                End Using
                inText = Convert.ToBase64String(mStream.ToArray())
            End Using
        End Using
        Return inText
    End Function

    'Decrypting a string
    Public Shared Function passwordDecrypt(ByVal cryptTxt As String, ByVal key As String) As String
        cryptTxt = cryptTxt.Replace(" ", "+")
        Dim bytesBuff As Byte() = Convert.FromBase64String(cryptTxt)
        Using aes__1 As Aes = Aes.Create()
            Dim crypto As New Rfc2898DeriveBytes(key, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D,
             &H65, &H64, &H76, &H65, &H64, &H65,
             &H76})
            aes__1.Key = crypto.GetBytes(32)
            aes__1.IV = crypto.GetBytes(16)
            Using mStream As New MemoryStream()
                Using cStream As New CryptoStream(mStream, aes__1.CreateDecryptor(), CryptoStreamMode.Write)
                    cStream.Write(bytesBuff, 0, bytesBuff.Length)
                    cStream.Close()
                End Using
                cryptTxt = Encoding.Unicode.GetString(mStream.ToArray())
            End Using
        End Using
        Return cryptTxt
    End Function

    <WebMethod()>
    Public Shared Function getData(ByVal data As String, db As String) As String

        Dim SQLConnect As SqlConnection = dbOpen(db)

        Dim campo As String, valore As String
        Dim elenco() As String = data.Split("{")(1).Split("}")(0).Split(",")
        Dim sp As String = elenco(0).Replace(Chr(34), "").Split(":")(1)
        Dim tabella As String = elenco(1).Replace(Chr(34), "").Split(":")(1)

        Dim SQL_Command_Read As SqlCommand = New SqlCommand(sp)

        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        For Each record In elenco
            campo = record.Split(":")(0).Replace(Chr(34), "")
            valore = record.Split(":")(1).Replace(Chr(34), "")
            SQL_Command_Read.Parameters.AddWithValue("@" & campo, valore)
        Next

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()

        Using SQL_Data As New SqlDataAdapter
            SQL_Data.SelectCommand = SQL_Command_Read
            Using dataSet As New DataSet()
                SQL_Data.Fill(dataSet, tabella)
                Return dataSet.GetXml()
            End Using
        End Using

        'Catch ex As Exception
        '    'MsgBox(ex.ToString)
        '    Return ex.ToString
        'End Try

        dbClose(SQL_Command_Read, SQLConnect)

    End Function

    <WebMethod()>
    Public Shared Function updData(ByVal data As String, html As String, db As String) As Integer

        Dim SQLConnect As SqlConnection = dbOpen(db)

        Dim campo As String, valore As String, Esito As Integer
        Dim elenco() As String = data.Split("{")(1).Split("}")(0).Split(",")

        Dim sp As String = elenco(0).Replace(Chr(34), "").Split(":")(1)

        Dim SQL_Command_Read As SqlCommand = New SqlCommand(sp)
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        For Each record In elenco
            campo = record.Split(":")(0).Replace(Chr(34), "")
            valore = record.Split(":")(1).Replace(Chr(34), "")
            SQL_Command_Read.Parameters.AddWithValue("@" & campo, valore)
        Next

        If Len(html) > 0 Then
            Dim myText() As String = html.Split("§")
            For Each testo In myText
                campo = testo.Split("#")(0) '.Replace(Chr(34), "")
                valore = testo.Split("#")(1) '.Replace(Chr(34), "")
                SQL_Command_Read.Parameters.AddWithValue("@" & campo, valore)
            Next
        End If

        SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
        SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()

        Esito = Convert.ToInt32(SQL_Command_Read.Parameters("@OK").Value)

        dbClose(SQL_Command_Read, SQLConnect)

        Return Esito

    End Function

    <WebMethod()>
    Public Shared Function getStruttura(tabella As String, db As String) As String

        Dim SQLConnect As SqlConnection = dbOpen(db)

        Dim SQL_Command_Read As SqlCommand = New SqlCommand("getStruttura")
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        SQL_Command_Read.Parameters.AddWithValue("@table", tabella)

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()
        Using SQL_Data As New SqlDataAdapter
            SQL_Data.SelectCommand = SQL_Command_Read
            Using dataSet As New DataSet()
                SQL_Data.Fill(dataSet, tabella)
                Return dataSet.GetXml()
            End Using
        End Using

        dbClose(SQL_Command_Read, SQLConnect)

    End Function

    Public Shared Function IsValidEmailFormat(ByVal email As String) As Boolean

        Try
            Dim newEmail As New MailAddress(email)
        Catch
            Return False
        End Try

        Return True

    End Function

    <WebMethod()>
    Public Shared Function SendMail(ByVal data As String, ByVal emailStud As String, ByVal emailProf As String, emailSede As String, ragioneSociale As String, db As String) As String

        Dim campo As String, valore As String
        Dim elenco() As String = data.Split("{")(1).Split("}")(0).Split(",")
        Dim sp As String = elenco(0).Replace(Chr(34), "").Split(":")(1)

        Dim mailMsg As New MailMessage()

        'Try
        Dim Body As String = String.Empty
        Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\sendReport.htm")
            Body = Reader.ReadToEnd
            For Each record In elenco
                campo = record.Split(":")(0).Replace(Chr(34), "")
                valore = record.Split(":")(1).Replace(Chr(34), "")

                If campo = "gruppoStud" Then
                    Body = Body.Replace("{" & campo & "}", IIf(valore = "True", " (+N)", ""))
                End If

                If campo = "distanza" Then
                    'MsgBox("Valore: " & valore)
                    Body = Body.Replace("{" & campo & "}", IIf(valore = 1, " a Distanza", "  di Presenza"))
                End If

                Body = Body.Replace("{" & campo & "}", valore)
            Next
            Body = Body.Replace("{ragioneSociale}", ragioneSociale)
        End Using


        mailMsg.From = New MailAddress("portofrancoAlert@valeriomcse.eu")

        If IsValidEmailFormat(emailProf) Then
            mailMsg.To.Add(emailProf)
        End If

        If IsValidEmailFormat(emailStud) Then
            mailMsg.To.Add(emailStud)
        End If

        mailMsg.CC.Add(emailSede)

        mailMsg.Bcc.Add("valeriomcse@hotmail.com")

        mailMsg.IsBodyHtml = True
        mailMsg.Subject = "Portofranco - Aggiornamento lezione"

        mailMsg.Body = Body

        Dim userData As SqlDataReader = getString("admGetService", 1, db)
        userData.Read()

        Dim MailUser As New NetworkCredential()
        MailUser.UserName = userData("utente")
        MailUser.Password = passwordDecrypt(userData("pw"), userData("utente"))

        userData.Close()

        MsgBox(MailUser.Password)

        Dim smtp As New SmtpClient()
        smtp.Host = "smtp.valeriomcse.eu"
        smtp.EnableSsl = False
        smtp.UseDefaultCredentials = False
        smtp.Credentials = MailUser
        smtp.Port = 25

        smtp.Send(mailMsg)

        'Catch Err As Exception

        '    Return "<sendmail>" & Chr(13) & "<esito>" & Err.Message.ToString & "</esito>" & Chr(13) & "<codice>0</codice>" & Chr(13) & "</sendmail>"

        'End Try

        'Return "<sendmail>" & Chr(13) & "<esito> Messagio inviato con successo </esito>" & Chr(13) & "<codice>1</codice>" & Chr(13) & "</sendmail>"
        Return "Messagio inviato con successo"

    End Function

    <WebMethod()>
    Public Shared Function SendMailConvocazione(ByVal data As String, html As String, ByVal elencoSoci As String, straord As String, tipoAss As String, db As String) As String

        Dim campo As String, valore As String

        Dim elencoCampi() As String = data.Split("{")(1).Split("}")(0).Split(",")
        Dim elencoHTML() As String = html.Split("§")
        Dim elencoUtenti() As String = elencoSoci.Split("#")

        Dim Body As String = String.Empty
        Dim mailMsg As New MailMessage()

        Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\send" + Trim(tipoAss) + ".htm")
            Body = Reader.ReadToEnd

            For Each record In elencoCampi
                campo = record.Split(":")(0).Replace(Chr(34), "")
                valore = record.Split(":")(1).Replace(Chr(34), "")

                Body = Body.Replace("{" & campo & "}", valore)
            Next

            For Each record In elencoHTML
                campo = record.Split("#")(0).Replace(Chr(34), "")
                valore = record.Split("#")(1).Replace(Chr(34), "")

                Body = Body.Replace("{" & campo & "}", valore)
            Next

        End Using

        mailMsg.From = New MailAddress("portofrancoAdmin@valeriomcse.eu")

        'mailMsg.CC.Add("portofranco.pa@gmail.com")

        mailMsg.Bcc.Add("valeriomcse@hotmail.com")

        mailMsg.IsBodyHtml = True
        mailMsg.Subject = "Portofranco - Convocazione " & tipoAss & " " & straord

        mailMsg.Body = Body


        Dim userData As SqlDataReader = getString("admGetService", 1, db)
        userData.Read()

        Dim MailUser As New NetworkCredential()
        MailUser.UserName = userData("utente")
        MailUser.Password = passwordDecrypt(userData("pw"), userData("utente"))

        userData.Close()

        Dim smtp As New SmtpClient()
        smtp.Host = "smtp.valeriomcse.eu"
        smtp.EnableSsl = False
        smtp.UseDefaultCredentials = False
        smtp.Credentials = MailUser
        smtp.Port = 25

        For Each userMail In elencoUtenti
            If IsValidEmailFormat(userMail) Then
                mailMsg.To.Add(userMail)
                'mailMsg.Bcc.Add("valeriomcse@hotmail.com")
                smtp.Send(mailMsg)
                mailMsg.To.Clear()
                mailMsg.Bcc.Clear()
            End If
        Next

        Return "send"

    End Function

    <WebMethod()>
    Public Shared Function sendMailResetPW(data As String, email As String, db As String) As String

        Dim campo As String, valore As String, codice As Integer
        Dim elencoCampi() As String = data.Split("{")(1).Split("}")(0).Split(",")

        Try
            Dim Mail2New As New MailMessage()
            Mail2New.From = New MailAddress("portofrancoAlert@valeriomcse.eu")
            Mail2New.To.Add(email)
            Mail2New.Bcc.Add("valeriomcse@hotmail.com")
            'Mail2New.Bcc.Add("portofranco.pa@gmail.com")
            Mail2New.IsBodyHtml = True
            Mail2New.Subject = "Sistema PROF - Avviso Reset Password"

            Dim Body As String = String.Empty

            Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\avvisoResetAuth.htm")
                Body = Reader.ReadToEnd
                For Each record In elencoCampi
                    campo = record.Split(":")(0).Replace(Chr(34), "")
                    valore = record.Split(":")(1).Replace(Chr(34), "")

                    Body = Body.Replace("{" & campo & "}", valore)
                Next
            End Using

            Mail2New.Body = Body


            Dim userData As SqlDataReader = getString("admGetService", 1, db)
            userData.Read()

            Dim MailUser As New NetworkCredential()
            MailUser.UserName = userData("utente")
            MailUser.Password = passwordDecrypt(userData("pw"), userData("utente"))

            userData.Close()

            Dim smtp As New SmtpClient()
            smtp.Host = "smtp.valeriomcse.eu"
            smtp.EnableSsl = False
            smtp.UseDefaultCredentials = False
            smtp.Credentials = MailUser
            smtp.Port = 25
            smtp.Send(Mail2New)

            'esito = "E' stata inviata la mail di notifica all'utente: " + user
            codice = 1

        Catch Err As Exception
            'esito = Err.Message.ToString & Chr(13) & "Il cambio della password è avvenuto con successo, ma non è stato possibile inviare la mail!"
            codice = 0

        End Try

        Return codice

    End Function

    <WebMethod()>
    Public Shared Function SendCheckCode(ByVal data As String, email As String, db As String) As String

        Dim campo As String, valore As String
        Dim elenco() As String = data.Split("{")(1).Split("}")(0).Split(",")
        'Dim sp As String = elenco(0).Replace(Chr(34), "").Split(":")(1)

        Dim mailMsg As New MailMessage()

        'Try
        Dim Body As String = String.Empty

        Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\sendCode.htm")
            Body = Reader.ReadToEnd
            For Each record In elenco
                campo = record.Split(":")(0).Replace(Chr(34), "")
                valore = record.Split(":")(1).Replace(Chr(34), "")
                Body = Body.Replace("{" & campo & "}", valore)
            Next
        End Using

        mailMsg.From = New MailAddress("portofrancoAlert@valeriomcse.eu")

        If IsValidEmailFormat(email) Then
            mailMsg.To.Add(email)
        End If

        'mailMsg.CC.Add("portofranco.pa@gmail.com")

        mailMsg.Bcc.Add("valeriomcse@hotmail.com")

        mailMsg.IsBodyHtml = True
        mailMsg.Subject = "Sistema PROF - Invio Codice di Controllo"

        mailMsg.Body = Body


        Dim userData As SqlDataReader = getString("admGetService", 1, db)
        userData.Read()

        Dim MailUser As New NetworkCredential()
        MailUser.UserName = userData("utente")
        MailUser.Password = passwordDecrypt(userData("pw"), userData("utente"))

        userData.Close()


        Dim smtp As New SmtpClient()
        smtp.Host = "smtp.valeriomcse.eu"
        smtp.EnableSsl = False
        smtp.UseDefaultCredentials = False
        smtp.Credentials = MailUser
        smtp.Port = 25

        smtp.Send(mailMsg)

        'Catch Err As Exception

        '    Return "<sendmail>" & Chr(13) & "<esito>" & Err.Message.ToString & "</esito>" & Chr(13) & "<codice>0</codice>" & Chr(13) & "</sendmail>"

        'End Try

        Return "Codice inviato con successo"

    End Function

    <WebMethod()>
    Public Shared Function SendSMS(ByVal myData As String, ByVal db As String) As String
        Dim myReq As HttpWebRequest
        Dim myResp As HttpWebResponse

        Dim userData As SqlDataReader = getString("admGetService", 2, db)
        userData.Read()

        Dim myUser As String = userData("utente")
        Dim myPass As String = passwordDecrypt(userData("pw"), userData("utente")) ' "sendSMS2020"
        userData.Close()

        myReq = HttpWebRequest.Create("https://api.labsmobile.com/json/send")
        myReq.Method = "POST"
        myReq.ContentType = "application/json"
        myReq.Headers.Add("Authorization", "Basic " & Convert.ToBase64String(Encoding.UTF8.GetBytes(myUser & ":" & myPass)))

        myReq.GetRequestStream.Write(System.Text.Encoding.UTF8.GetBytes(myData), 0, System.Text.Encoding.UTF8.GetBytes(myData).Count)
        myResp = myReq.GetResponse

        Dim myreader As New System.IO.StreamReader(myResp.GetResponseStream)
        Dim myText As String

        myText = myreader.ReadToEnd

        'MsgBox(myText)

        Return myText

    End Function

    <WebMethod()>
    Public Shared Function uploadFile(ByVal file As String, path As String, filename As String) As String

        Dim filepath As String = HttpRuntime.AppDomainAppPath & path
        Dim fs As New FileStream(filepath & filename, FileMode.Create)

        Try
            Dim myFileBinary() As Byte = Convert.FromBase64String(file)
            fs.Write(myFileBinary, 0, myFileBinary.Length)


        Catch ex As Exception
            Return ex.Message

        End Try

        fs.Close()

        Return "Elaborazione conclusa con successo!"

    End Function

End Class
