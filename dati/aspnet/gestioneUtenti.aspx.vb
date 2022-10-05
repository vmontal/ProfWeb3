Imports System.Data
Imports System.Data.SqlClient
'Imports System.Configuration
Imports System.Web.Configuration
Imports System.Web.Services
Imports System.IO
Imports System.Security.Cryptography
Imports System.Net
Imports System.Net.Mail
'Imports System.Net.Mime

Partial Class gestioneUtenti
    Inherits System.Web.UI.Page

    Public Shared Function openDB(db As String) As SqlConnection
        Dim ConnectDB As New SqlConnection(WebConfigurationManager.ConnectionStrings(db).ConnectionString)
        'Dim ConnectDB As New SqlConnection("Data Source=MONTALBANO\SQLEXPRESS1901; Initial Catalog=MSSql99362; Integrated Security=True")
        Return ConnectDB

    End Function

    Public Shared Function closeDB(command As SqlCommand, connect As SqlConnection) As Int16
        command.Connection.Close()
        command.Connection.Dispose()

        connect.Close()
        connect.Dispose()
        SqlConnection.ClearPool(connect)

        Return 0

    End Function

    Public Shared Function getString(storeProcedure As String, servizio As Integer, db As String) As SqlDataReader
        Dim SQLConnect As SqlConnection = openDB(db)

        Dim dataCommand As New SqlCommand(storeProcedure, SQLConnect)
        dataCommand.CommandType = CommandType.StoredProcedure
        dataCommand.Parameters.AddWithValue("@idSer", servizio)
        SQLConnect.Open()

        Dim dataReader As SqlDataReader = dataCommand.ExecuteReader()

        Return dataReader

        closeDB(dataCommand, SQLConnect)

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

    <WebMethod()> _
    Public Shared Function admLogin(utente As String, password As String, db As String) As String

        Dim SQLConnect As SqlConnection = openDB(db)

        Dim SQL_Command_Read As SqlCommand = New SqlCommand("admLogin")
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        SQL_Command_Read.Parameters.AddWithValue("@User", utente)
        SQL_Command_Read.Parameters.AddWithValue("@pass", password)
        SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
        SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()

        Using SQL_Data As New SqlDataAdapter
            SQL_Data.SelectCommand = SQL_Command_Read
            Using dataSet As New DataSet()
                SQL_Data.Fill(dataSet, "Utente")
                Return dataSet.GetXml()
            End Using
        End Using

        closeDB(SQL_Command_Read, SQLConnect)

    End Function

    '<WebMethod()> _
    'Public Shared Function admElencoUtenti(ID As Integer, db As String) As String

    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admUtentiRead")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure
    '    SQL_Command_Read.Parameters.AddWithValue("@id", ID)

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "ElencoUtenti")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admRuoloSelect(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    'Elenco Ruoli
    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admRuoliRead")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "Ruoli")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admGruppoSelect(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    'Elenco Gruppi
    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admGruppoSelect")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "Gruppi")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admElencoProf(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    'Elenco Professioni
    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admElencoProf")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "Professioni")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admElencoProfili(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    'Elenco Profili
    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admElencoProfili")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "Profili")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admDominioSelect(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    'Elenco Gruppi
    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admDominioSelect")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Using SQL_Data As New SqlDataAdapter
    '        SQL_Data.SelectCommand = SQL_Command_Read
    '        Using dataSet As New DataSet()
    '            SQL_Data.Fill(dataSet, "Domini")
    '            Return dataSet.GetXml()
    '        End Using
    '    End Using

    '    closeDB(SQL_Command_Read, SQLConnect)

    'End Function

    '<WebMethod()> _
    'Public Shared Function admGruppoUpdate(ID_Gruppo As Integer, gruppo As String, ID_Profilo As Integer, db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim Esito As Integer = 0

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admGruppoUpdate")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Gruppo", ID_Gruppo)
    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Profilo", ID_Profilo)
    '    SQL_Command_Read.Parameters.AddWithValue("@Gruppo", gruppo)

    '    SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
    '    SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return "<Gruppo><ID>" & Esito & "</ID></Gruppo>"

    'End Function

    '<WebMethod()> _
    'Public Shared Function admGruppoDelete(ID_Gruppo As Integer, db As String) As Int16

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim Esito As Int16 = 0

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admGruppoDelete")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Gruppo", ID_Gruppo)

    '    SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
    '    SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return Esito

    'End Function

    '<WebMethod()> _
    'Public Shared Function admDominioUpdate(ID_Gruppo As Integer, ID_Cliente As Integer, db As String) As Int16

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim Esito As Int16 = 0

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admDominioUpdate", SQLConnect)
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Gruppo", ID_Gruppo)
    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Cliente", ID_Cliente)

    '    SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
    '    SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    If (IsDBNull(SQL_Command_Read.Parameters("@OK").Value)) Then
    '        Esito = 0
    '    Else
    '        Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)
    '    End If

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return Esito

    'End Function

    '<WebMethod()> _
    'Public Shared Function admDominioDelete(ID_Gruppo As Integer, ID_Cliente As Integer, db As String) As Int16

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim Esito As Int16 = 0

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admDominioDelete", SQLConnect)
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Gruppo", ID_Gruppo)
    '    SQL_Command_Read.Parameters.AddWithValue("@ID_Cliente", ID_Cliente)

    '    SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
    '    SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    If (IsDBNull(SQL_Command_Read.Parameters("@OK").Value)) Then
    '        Esito = 0
    '    Else
    '        Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)
    '    End If

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return Esito

    'End Function

    '<WebMethod()> _
    'Public Shared Function admElencoRuoliXML(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim xmlRuoli As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)

    '    SQLConnect.Open()

    '    'Elenco Ruoli
    '    Dim SQL_Command_Read As New SqlCommand()
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandText = "Select ID_Ruolo, Descrizione FROM admRuoli"
    '    Dim rs_structure As SqlDataReader = SQL_Command_Read.ExecuteReader()

    '    xmlRuoli += "<Elenco>" & Chr(13)
    '    Do While rs_structure.Read
    '        xmlRuoli += "<ruolo>" & Chr(13)
    '        xmlRuoli += "<id>" & rs_structure("idRuolo") & "</id>" & Chr(13)
    '        xmlRuoli += "<descrizione>" & rs_structure("Descrizione") & "</descrizione>" & Chr(13)
    '        xmlRuoli += "</ruolo>" & Chr(13)
    '    Loop
    '    xmlRuoli += "</Elenco>"

    '    rs_structure.Close()

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return xmlRuoli

    'End Function

    '<WebMethod()> _
    'Public Shared Function admElencoGruppiXML(db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim xmlGruppi As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)

    '    SQLConnect.Open()

    '    'Elenco Gruppi
    '    Dim SQL_Command_Read As New SqlCommand()
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandText = "Select ID_Gruppo, Gruppo FROM admGruppi"
    '    Dim rs_structure As SqlDataReader = SQL_Command_Read.ExecuteReader()

    '    xmlGruppi += "<ElencoGruppi>" & Chr(13)
    '    Do While rs_structure.Read
    '        xmlGruppi += "<gruppo>" & Chr(13)
    '        xmlGruppi += "<id>" & rs_structure("ID_Gruppo") & "</id>" & Chr(13)
    '        xmlGruppi += "<descrizione>" & rs_structure("Gruppo") & "</descrizione>" & Chr(13)
    '        xmlGruppi += "</gruppo>" & Chr(13)
    '    Loop
    '    xmlGruppi += "</ElencoGruppi>"

    '    rs_structure.Close()

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return xmlGruppi

    'End Function

    '<WebMethod()> _
    'Public Shared Function admAggiornaUtente(ID As Integer, cognome As String, nome As String, email As String, username As String, password As String, attivo As Integer, idRuolo As Integer, privacy As Integer, adv As Integer, db As String) As String

    '    'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
    '    'Dim SQLConnect As New SqlConnection(stringDB)
    '    Dim SQLConnect As SqlConnection = openDB(db)

    '    Dim Esito As Integer = 0

    '    Dim SQL_Command_Read As SqlCommand = New SqlCommand("admAggiornaUtente")
    '    SQL_Command_Read.Connection = SQLConnect
    '    SQL_Command_Read.CommandType = CommandType.StoredProcedure

    '    SQL_Command_Read.Parameters.AddWithValue("@ID", ID)
    '    SQL_Command_Read.Parameters.AddWithValue("@cognome", cognome)
    '    SQL_Command_Read.Parameters.AddWithValue("@nome", nome)
    '    SQL_Command_Read.Parameters.AddWithValue("@email", email)
    '    SQL_Command_Read.Parameters.AddWithValue("@username", username)
    '    SQL_Command_Read.Parameters.AddWithValue("@password", password)
    '    SQL_Command_Read.Parameters.AddWithValue("@attivo", attivo)
    '    SQL_Command_Read.Parameters.AddWithValue("@idRuolo", idRuolo)
    '    SQL_Command_Read.Parameters.AddWithValue("@privacy", privacy)
    '    SQL_Command_Read.Parameters.AddWithValue("@adv", adv)

    '    SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
    '    SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

    '    SQLConnect.Open()
    '    SQL_Command_Read.ExecuteNonQuery()
    '    Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

    '    closeDB(SQL_Command_Read, SQLConnect)

    '    Return "<Utente><ID>" & Esito & "</ID></Utente>"

    'End Function

    <WebMethod()>
    Public Shared Function admAggiornaPassword(ID As Integer, password As String, idRS As Integer, db As String) As String

        'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
        'Dim SQLConnect As New SqlConnection(stringDB)
        Dim SQLConnect As SqlConnection = openDB(db)

        Dim Esito As Integer = 0

        Dim SQL_Command_Read As SqlCommand = New SqlCommand("admPasswordUpdate")
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        SQL_Command_Read.Parameters.AddWithValue("@ID", ID)
        SQL_Command_Read.Parameters.AddWithValue("@password", password)
        SQL_Command_Read.Parameters.AddWithValue("@idRS", idRS)

        SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
        SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()
        Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

        closeDB(SQL_Command_Read, SQLConnect)

        Return Esito

    End Function

    <WebMethod()> _
    Public Shared Function admResetPassword(ID As Integer, newPass As String, db As String) As String

        'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
        'Dim SQLConnect As New SqlConnection(stringDB)
        Dim SQLConnect As SqlConnection = openDB(db)

        Dim Esito As Integer = 0

        Dim SQL_Command_Read As SqlCommand = New SqlCommand("admPasswordReset")
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        SQL_Command_Read.Parameters.AddWithValue("@ID", ID)
        SQL_Command_Read.Parameters.AddWithValue("@newPass", newPass)

        SQL_Command_Read.Parameters.Add("@OK", SqlDbType.Int)
        SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()
        Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)

        closeDB(SQL_Command_Read, SQLConnect)

        Return "<Utente><ID>" & Esito & "</ID></Utente>"

    End Function

    <WebMethod()> _
    Public Shared Function mailResetUtente(mail As String, user As String, np As String, db As String) As String

        Dim esito As String = String.Empty
        Dim codice As Integer = 0
        Dim xmlMail As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)

        Try
            Dim Mail2New As New MailMessage()
            Mail2New.From = New MailAddress("portofrancoAlert@valeriomcse.eu")
            Mail2New.To.Add(mail)
            'Mail2New.Bcc.Add("portofranco.pa@gmail.com")
            Mail2New.Bcc.Add("valeriomcse@hotmail.com")
            Mail2New.IsBodyHtml = True
            Mail2New.Subject = "Reset utente per: " & mail

            Dim Body As String = String.Empty
            Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\resetUtente.htm")
                Body = Reader.ReadToEnd
                Body = Body.Replace("{user}", user)
                Body = Body.Replace("{password}", np)
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

            esito = "E' stata inviata una mail all'indirizzo che hai registrato per il reset delle credenziali di accesso"
            codice = 1

        Catch Err As Exception
            esito = Err.Message.ToString & Chr(13) & "Il reset della password è avvenuto con successo, ma non è stato possibile inviare la mail!"
            codice = 0

        End Try

        xmlMail = xmlMail + "<sendmail>" & Chr(13)
        xmlMail = xmlMail + "<codice>" & codice & "</codice>" & Chr(13)
        xmlMail = xmlMail + "<esito>" & esito & "</esito>" & Chr(13)
        xmlMail = xmlMail + "</sendmail>"

        Return xmlMail

    End Function

    <WebMethod()>
    Public Shared Function mailVerificaUtente(user As String, mail As String, host As String, db As String, rs As String, email As String, form As String) As String

        Dim esito As String = String.Empty
        Dim codice As Integer = 0
        Dim xmlMail As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)
        Dim invioVerifica As String = IIf(form = "Utente", "verificaUtente.htm", "verificaMail.htm")

        Try
            Dim Mail2New As New MailMessage()
            Mail2New.From = New MailAddress("portofrancoAlert@valeriomcse.eu")
            Mail2New.To.Add(mail)
            Mail2New.Bcc.Add("valeriomcse@hotmail.com")
            'Mail2New.Bcc.Add("portofranco.pa@gmail.com")
            Mail2New.IsBodyHtml = True
            Mail2New.Subject = "Verifica mail per " & form & ": " & user

            Dim Body As String = String.Empty
            Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\" & invioVerifica)
                Body = Reader.ReadToEnd
                Body = Body.Replace("{linkMail}", "https://" & host & "/html/mail/controlloMail.htm?mail=" & mail & "&form=" & form & "&db=" & db & Chr(13))
                Body = Body.Replace("{email}", mail)
                Body = Body.Replace("{utenteTipo}", form)
                Body = Body.Replace("{user}", user)
                Body = Body.Replace("{password}", user)
                Body = Body.Replace("{ragioneSociale}", rs)
                Body = Body.Replace("{emailSede}", email)
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

            esito = "E' stata inviata una mail all'indirizzo che hai registrato per la verifica dei dati "
            codice = 1

        Catch Err As Exception
            esito = Err.Message.ToString & Chr(13) & "Attenzione; non è stato possibile inviare la mail!"
            codice = 0

        Finally
            xmlMail = xmlMail + "<sendmail>" & Chr(13)
            xmlMail = xmlMail + "<codice>" & codice & "</codice>" & Chr(13)
            xmlMail = xmlMail + "<esito>" & esito & "</esito>" & Chr(13)
            xmlMail = xmlMail + "</sendmail>"

        End Try

        Return xmlMail

    End Function

    <WebMethod()>
    Public Shared Function mailAvvisoModifica(user As String, mail As String, host As String, ruolo As String, db As String) As String

        Dim esito As String = String.Empty
        Dim codice As Integer = 0
        Dim msg As String = String.Empty
        Dim xmlMail As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)

        Try
            Dim Mail2New As New MailMessage()
            Mail2New.From = New MailAddress("portofrancoAlert@valeriomcse.eu")
            Mail2New.To.Add(mail)
            Mail2New.Bcc.Add("valeriomcse@hotmail.com")
            'Mail2New.Bcc.Add("portofranco.pa@gmail.com")
            Mail2New.IsBodyHtml = True
            Mail2New.Subject = "Avviso Modifica Profilo per utente: " & user

            Dim Body As String = String.Empty
            Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\avvisoModifica.htm")
                Body = Reader.ReadToEnd
                Body = Body.Replace("{ruolo}", ruolo)
                'Body = Body.Replace("{gruppo}", gruppo)
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

            esito = "E' stata inviata la mail di notifica all'utente: " + user
            codice = 1

        Catch Err As Exception
            esito = "Attenzione; non è stato possibile inviare la mail!"
            msg = Err.Message.ToString
            codice = 0

        Finally
            xmlMail = xmlMail + "<sendmail>" & Chr(13)
            xmlMail = xmlMail + "<codice>" & codice & "</codice>" & Chr(13)
            xmlMail = xmlMail + "<esito>" & esito & "</esito>" & Chr(13)
            xmlMail = xmlMail + "<msg>" & msg & "</msg>" & Chr(13)
            xmlMail = xmlMail + "</sendmail>"

        End Try

        Return xmlMail

    End Function

    <WebMethod()>
    Public Shared Function mailResetPassword(user As String, mail As String, resetAuth As Boolean, resetUser As Boolean, sede As String, emailSede As String, db As String) As String

        Dim esito As String = String.Empty
        Dim codice As Integer = 0
        'Dim xmlMail As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)
        'MsgBox(mail)
        Try
            Dim Mail2New As New MailMessage()
            Mail2New.From = New MailAddress("portofrancoAlert@valeriomcse.eu")
            Mail2New.To.Add(mail)
            Mail2New.Bcc.Add("valeriomcse@hotmail.com")
            'Mail2New.Bcc.Add("portofranco.pa@gmail.com")
            Mail2New.IsBodyHtml = True
            Mail2New.Subject = "Avviso Modifica Password per utente: " & user

            Dim Body As String = String.Empty

            If resetAuth Then
                Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\avvisoResetAuth.htm")
                    Body = Reader.ReadToEnd
                    Body = Body.Replace("{user}", user)
                    Body = Body.Replace("{password}", user)
                    Body = Body.Replace("{sede}", sede)
                    Body = Body.Replace("{emailSede}", emailSede)
                End Using
            Else
                Using Reader As StreamReader = New StreamReader(HttpRuntime.AppDomainAppPath & "\html\mail\avvisoResetUser.htm")
                    Body = Reader.ReadToEnd
                    Body = Body.Replace("{sede}", sede)
                    Body = Body.Replace("{emailSede}", emailSede)
                End Using
            End If


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
            'MsgBox(Err.Message.ToString)

            'Finally
            '    xmlMail = xmlMail + "<sendmail>" & Chr(13)
            '    xmlMail = xmlMail + "<codice>" & codice & "</codice>" & Chr(13)
            '    xmlMail = xmlMail + "<esito>" & esito & "</esito>" & Chr(13)
            '    xmlMail = xmlMail + "</sendmail>"

        End Try

        Return codice

    End Function

    <WebMethod()>
    Public Shared Function admResetUtente(email As String, newPass As String, db As String) As String
        'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
        'Dim SQLConnect As New SqlConnection(stringDB)
        Dim SQLConnect As SqlConnection = openDB(db)

        Dim SQL_Command_Read As SqlCommand = New SqlCommand("admResetUtente")
        SQL_Command_Read.Connection = SQLConnect
        SQL_Command_Read.CommandType = CommandType.StoredProcedure

        SQL_Command_Read.Parameters.AddWithValue("@mail", email)
        SQL_Command_Read.Parameters.AddWithValue("@newPass", newPass)

        SQLConnect.Open()
        SQL_Command_Read.ExecuteNonQuery()
        Using SQL_Data As New SqlDataAdapter
            SQL_Data.SelectCommand = SQL_Command_Read
            Using dataSet As New DataSet()
                SQL_Data.Fill(dataSet, "reset")
                Return dataSet.GetXml()
            End Using
        End Using

        closeDB(SQL_Command_Read, SQLConnect)

    End Function

    <WebMethod()> _
    Public Shared Function admVerificaMail(mail As String, form As String, db As String) As String

        'Dim stringDB As String = WebConfigurationManager.ConnectionStrings("DBdataPro").ConnectionString
        'Dim SQLConnect As New SqlConnection(stringDB)
        Dim SQLConnect As SqlConnection = openDB(db)

        Dim Esito As Integer = 0
        Dim TestoEsito As String = String.Empty
        Dim xmlEsito As String = "<?xml version='1.0' encoding='utf-8' ?>" & Chr(13)
        Dim SQL_Command_Read As SqlCommand = New SqlCommand("admVerificaMail")

        Try

            SQL_Command_Read.Connection = SQLConnect
            SQL_Command_Read.CommandType = CommandType.StoredProcedure

            SQL_Command_Read.Parameters.AddWithValue("@mail", mail)
            SQL_Command_Read.Parameters.AddWithValue("@form", form)

            SQL_Command_Read.Parameters.AddWithValue("@OK", 0)
            SQL_Command_Read.Parameters.AddWithValue("@testo", "")
            SQL_Command_Read.Parameters("@testo").Size = 100
            SQL_Command_Read.Parameters("@OK").Direction = ParameterDirection.Output
            SQL_Command_Read.Parameters("@testo").Direction = ParameterDirection.Output


            SQLConnect.Open()
            SQL_Command_Read.ExecuteNonQuery()

            Esito = Convert.ToInt16(SQL_Command_Read.Parameters("@OK").Value)
            TestoEsito = SQL_Command_Read.Parameters("@testo").Value

        Catch Err As SqlException
            Esito = -1
            TestoEsito = Err.Message.ToString & Chr(13) & "Errore accesso al DB"

        Finally
            xmlEsito = xmlEsito & "<verifica>" & Chr(13)
            xmlEsito = xmlEsito & "<esito>" & Esito & "</esito>" & Chr(13)
            xmlEsito = xmlEsito & "<testo>" & TestoEsito & "</testo>" & Chr(13)
            xmlEsito = xmlEsito & "</verifica>"

            closeDB(SQL_Command_Read, SQLConnect)

        End Try

        Return xmlEsito

    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

End Class
