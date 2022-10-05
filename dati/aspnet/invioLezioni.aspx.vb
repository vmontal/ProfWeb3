Imports System.Data
Imports System.Data.SqlClient
'Imports System.Configuration
'Imports System.Web.Services
Imports System.Web.Configuration
'Imports System.Web.Script.Serialization
Imports System.IO
Imports System.Security.Cryptography
'Imports System.Threading
Imports System.Net
Imports System.Net.Mail
'Imports System.Net.Mime

Partial Class invioLezioni
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim path As String = HttpRuntime.AppDomainAppPath
        Dim db As String = "DB_ProfWeb30" '{"DB_Ernesto"} '
        'Dim luogo As String() = {"Via Campolo presso Parrocchia S.Ernesto"} '{"Via Campolo presso Parrocchia S.Ernesto"} '
        Dim data As String
        Dim i As Integer = 0, idLezione As Integer = 1

        Dim logString As String = String.Empty
        Dim logStringOpen As String = "{"
        Dim logStringHeader As String = Chr(13) & "[" & Chr(13)
        Dim logStringBody As String = String.Empty
        Dim logStringFooter As String = Chr(13) & "]" & Chr(13)
        Dim logStringClose As String = "}"

        Dim logStringSeparaCampi As String = String.Empty
        Dim logStringSeparaSedi As String = String.Empty

        Try
            'For Each db In archivio
            'logStringHeader = Chr(34) & "[" & Chr(13)

            data = "{sp:pf_pianoOfferteOggiRead,tabella:offerteOggi}"
            Dim myData As SqlDataReader = getData(data, db)

            Do While myData.Read()
                Dim orario As String = myData("orarioHMS")
                orario = Left(orario.Replace(":", "-"), Len(orario) - 3)
                Dim record As String = "{statusOfferta:" & myData("statusOfferta") & ",nomeProf:" & myData("nomeProf") & ",nomeStud:" & myData("nomeStud") & ",istitutoTipo:" & myData("istitutoTipo") & ",anno:" & myData("anno") & ",materia:" & myData("materia") & ",orario:" & orario & ",dataOffertaGMA:" & myData("dataOffertaGMA") & ",luogo:" & myData("sede") & ",ragioneSociale:" & myData("ragioneSociale") & ",sedeLegaleIndirizzo:" & myData("sedeLegaleIndirizzo") & ",sedeLegaleLuogo:" & myData("sedeLegaleLuogo") & ",argomentoOfferta:" & myData("argomentoOfferta") & ",notaOfferta:" & myData("notaOfferta") & ",gruppoStud:" & myData("gruppoStud") & ",distanza:" & myData("distanza") & ",tel1Stud:" & myData("tel1Stud") & "}"
                logStringBody = logStringBody & logStringSeparaCampi & SendMail(record, myData("emailStud"), myData("emailprof"), path, idLezione, db)
                idLezione = idLezione + 1
                logStringSeparaCampi = "," & Chr(13)
            Loop

            data = "{sp:pf_pianoOfferteErogateUpdate,tabella:offerteErogate}"
            updData(data, db)
            idLezione = 1
            i = i + 1

            logString = logString & logStringHeader + logStringBody + logStringFooter
            logStringSeparaCampi = String.Empty
            'logStringSeparaSedi = "," & Chr(13)
            'logStringBody = String.Empty
            'Next

            logString = logStringOpen & logString & logStringClose

        Catch err As SqlException
            File.AppendAllText(path & "dati\log\logErrorUpdate.json", FormatDateTime(Today, DateFormat.LongDate) & " - " & logStringBody & Chr(13) & "{" & Chr(34) & "errorSQL" & Chr(34) & ":{[" & Chr(34) & "codice" & Chr(34) & ":" & Chr(34) & err.Message.ToString & Chr(34) & "]}}")
            SendReport(logStringBody & Chr(13) & "{" & Chr(34) & "errorSQL" & Chr(34) & ":{[" & Chr(34) & "codice" & Chr(34) & ":" & Chr(34) & err.Message.ToString & Chr(34) & "]}}", path, db)

        End Try

        File.WriteAllText(path & "dati\log\logUpdate.json", logString)
        SendReport(path, logString, db)

        data = "{sp:pf_anagrafeGeneraleCompleanni,tabella:auguri}"
        Dim myAuguri As SqlDataReader = getData(data, db)
        Dim nome As String, email As String

        Do While myAuguri.Read()
            nome = myAuguri("intestazione")
            email = myAuguri("email")
            sendAuguri(nome, email, path, db)
        Loop

    End Sub

    Public Shared Function dbOpen(db As String) As SqlConnection
        Dim ConnectDB As New SqlConnection(WebConfigurationManager.ConnectionStrings(db).ConnectionString)
        Return ConnectDB
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

    Public Shared Function dbClose(command As SqlCommand, connect As SqlConnection) As Int16
        command.Connection.Close()
        command.Connection.Dispose()

        connect.Close()
        connect.Dispose()
        SqlConnection.ClearPool(connect)

        Return 0

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

    Public Shared Function getData(ByVal Data As String, db As String) As SqlDataReader

        Dim SQLConnect As SqlConnection = dbOpen(db)

        Dim campo As String, valore As String

        Dim elenco() As String = Data.Split("{")(1).Split("}")(0).Split(",")
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

        Dim lezioni As SqlDataReader = SQL_Command_Read.ExecuteReader()

        Return lezioni

        dbClose(SQL_Command_Read, SQLConnect)

    End Function

    Public Shared Function updData(ByVal data As String, db As String) As Integer

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

        SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
        SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()

        Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

        dbClose(SQL_Command_Read, SQLConnect)

        Return Esito

    End Function

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

    Public Shared Sub sendAuguri(ByVal nome As String, ByVal email As String, path As String, db As String)
        Dim Body As String = String.Empty

        Try

            Using Reader As StreamReader = New StreamReader(path & "\html\mail\sendAuguri.htm")
                Body = Reader.ReadToEnd

                Body = Body.Replace("{nome}", nome)
            End Using

            Dim mailMsg As New MailMessage()
            mailMsg.From = New MailAddress("portofrancoAuguri@valeriomcse.eu")

            If IsValidEmailFormat(email) Then
                mailMsg.To.Add(email)
            End If

            mailMsg.CC.Add("portofranco.pa@gmail.com")
            mailMsg.Bcc.Add("valeriomcse@hotmail.com")
            mailMsg.IsBodyHtml = True
            mailMsg.Subject = "Tanti Auguri di buon compleanno!!!"
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

        Catch ex As Exception
            File.AppendAllText(path & "dati\log\logErrorSendAuguri.json", FormatDateTime(Today, DateFormat.LongDate) & " - " & ex.Message.ToString)

        End Try

    End Sub

    Public Shared Function SendMail(ByVal data As String, ByVal emailStud As String, ByVal emailProf As String, path As String, idLezione As Integer, db As String) As String

        Dim campo As String, valore As String
        Dim elenco() As String = data.Split("{")(1).Split("}")(0).Split(",")
        Dim jsonMsg As String = String.Empty, separa As String = String.Empty

        Try
            Dim Body As String = String.Empty

            jsonMsg = "{" & Chr(34) & "id" & Chr(34) & ":" & idLezione & "," & Chr(13)
            Using Reader As StreamReader = New StreamReader(path & "\html\mail\sendReport.htm")
                Body = Reader.ReadToEnd
                For Each record In elenco
                    campo = record.Split(":")(0).Replace(Chr(34), "")
                    valore = record.Split(":")(1).Replace(Chr(34), "")

                    If campo = "gruppoStud" Then
                        Body = Body.Replace("{" & campo & "}", IIf(valore = "True", " (+N)", ""))
                    End If

                    If campo = "distanza" Then
                        'MsgBox("valore: " & valore)
                        Body = Body.Replace("{" & campo & "}", IIf(valore = "True", " a Distanza", "  di Presenza"))
                    End If

                    Body = Body.Replace("{" & campo & "}", valore)

                    jsonMsg = jsonMsg & separa & Chr(34) & campo & Chr(34) & ":" & Chr(34) & valore & Chr(34)
                    separa = "," & Chr(13)
                Next
            End Using
            jsonMsg = jsonMsg & "}"

            Dim mailMsg As New MailMessage()
            mailMsg.From = New MailAddress("portofrancoAlert@valeriomcse.eu")

            If IsValidEmailFormat(emailProf) Then
                mailMsg.To.Add(emailProf)
            End If

            If IsValidEmailFormat(emailStud) Then
                mailMsg.To.Add(emailStud)
            End If

            'mailMsg.CC.Add("portofranco.pa@gmail.com")
            mailMsg.Bcc.Add("valeriomcse@hotmail.com")
            mailMsg.IsBodyHtml = True
            mailMsg.Subject = "Sistema PROF - Aggiornamento lezione"
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

        Catch Err As Exception
            jsonMsg = "{" & Chr(13) & Chr(34) & "error" & Chr(34) & ":" & Chr(34) & Err.Message.ToString & Chr(34) & "," & Chr(13) & Chr(34) & "codice" & Chr(34) & ":" & "0" & Chr(13) & "}"

        End Try

        Return jsonMsg

    End Function

    Public Shared Sub SendReport(path As String, logString As String, db As String)

        Try
            Dim mailMsg As New MailMessage()
            mailMsg.From = New MailAddress("portofrancoReport@valeriomcse.eu")
            'mailMsg.To.Add("portofranco.pa@gmail.com")
            mailMsg.Bcc.Add("valeriomcse@hotmail.com")
            mailMsg.IsBodyHtml = False
            mailMsg.Subject = "Sistema PROF - Elenco Lezioni del giorno: " & FormatDateTime(Today, DateFormat.LongDate)
            mailMsg.Body = logString

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

        Catch Err As Exception
            File.AppendAllText(path & "dati\log\logErrorReport.json", FormatDateTime(Today, DateFormat.LongDate) & " - " & Err.Message.ToString)

        End Try

    End Sub
End Class
