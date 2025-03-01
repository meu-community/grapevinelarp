VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "MummyClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Name As String
Public Amenti As String
Public Nature As String
Public Demeanor As String

Public Willpower As Integer
Public Sekhem As Integer
Public Balance As Integer
Public Memory As Integer
Public Integrity As Integer
Public Joy As Integer
Public Ba As Integer
Public Ka As Integer

Public TempWillpower As Integer
Public TempSekhem As Integer
Public TempBalance As Integer
Public TempMemory As Integer
Public TempIntegrity As Integer
Public TempJoy As Integer
Public TempBa As Integer
Public TempKa As Integer

Public PhysicalList As LinkedTraitList
Public SocialList As LinkedTraitList
Public MentalList As LinkedTraitList
Public PhysicalNegList As LinkedTraitList
Public SocialNegList As LinkedTraitList
Public MentalNegList As LinkedTraitList
Public PhysicalMax As Integer
Public SocialMax As Integer
Public MentalMax As Integer

Public AbilityList As LinkedTraitList
Public InfluenceList As LinkedTraitList

Public HumanityList As LinkedTraitList
Public StatusList As LinkedTraitList

Public BackgroundList As LinkedTraitList
Public HealthList As LinkedTraitList

Public HekauList As LinkedTraitList
Public SpellList As LinkedTraitList
Public RitualList As LinkedTraitList

Public MeritList As LinkedTraitList
Public FlawList As LinkedTraitList

Public EquipmentList As LinkedTraitList
Public HangoutList As LinkedTraitList
Public Inheritance As String
Public Biography As String
Public Notes As String

Public Player As String
Public Status As String
Public ID As String
Public StartDate As Date
Public Narrator As String
Public IsNPC As Boolean
Public Experience As ExperienceClass
Public LastModified As Date

Public Sub InitializeForOutput()
'
' Name:         InitializeForOutput
' Description:  For each list of data in this character,
'               move the cursor to the first item.  Used to
'               help generate character sheets.
'

    PhysicalList.First
    SocialList.First
    MentalList.First
    PhysicalNegList.First
    SocialNegList.First
    MentalNegList.First
    StatusList.First
    AbilityList.First
    HumanityList.First
    InfluenceList.First
    BackgroundList.First
    HealthList.First
    HekauList.First
    SpellList.First
    RitualList.First
    MeritList.First
    FlawList.First
    EquipmentList.First
    HangoutList.First
    Experience.InitializeForOutput

End Sub

Public Function OutputID() As Integer
'
' Name:         OutputID
' Description:  Return an ID that tells the OutputEngineClass how to manipulate this object
'
    OutputID = oidNone

End Function

Public Sub GetValue(Key As String, CharData As Variant)
'
' Name:         GetValue
' Parameters:   Key         a key (string) to the value to retreive
'               CharData    the returned value - a string, number, date or list
' Description:  Use the given key to return data from the character.  Keys are defined
'               in the PublicQueryKeys module.
'

    Select Case Key
        
        Case qkPlayStatus:      CharData = Status
        Case qkInfluences:      Set CharData = InfluenceList
        Case qkMerits:          Set CharData = MeritList
        Case qkFlaws:           Set CharData = FlawList
        Case qkBackgrounds:     Set CharData = BackgroundList
        Case qkNPC:             CharData = IsNPC
        Case qkAbilities:       Set CharData = AbilityList
        Case qkStatus:          Set CharData = StatusList
        Case qkEquipment:       Set CharData = EquipmentList
        Case qkLocations:       Set CharData = HangoutList
        Case qkPhysical:        Set CharData = PhysicalList
        Case qkSocial:          Set CharData = SocialList
        Case qkMental:          Set CharData = MentalList
        Case qkPhysicalNeg:     Set CharData = PhysicalNegList
        Case qkSocialNeg:       Set CharData = SocialNegList
        Case qkMentalNeg:       Set CharData = MentalNegList
        Case qkXPEarned:        CharData = Experience.Earned
        Case qkXPUnspent:       CharData = Experience.Unspent
        Case qkNature:          CharData = Nature
        Case qkDemeanor:        CharData = Demeanor
        Case qkRace:            CharData = Race
        Case qkGroup:           CharData = Group
        Case qkSubgroup:        CharData = Subgroup
        Case qkWillpower:       CharData = Willpower
        Case qkTempWillpower:   CharData = TempWillpower
        Case qkLastModified:    CharData = LastModified
        Case qkStartDate:       CharData = StartDate
        Case qkHealth:          Set CharData = HealthList
        Case qkNotes:           CharData = Notes
        Case qkID:              CharData = ID
        Case qkPlayer:          CharData = Player
        Case qkNarrator:        CharData = Narrator
        Case qkName:            CharData = Name
        Case qkEMail:           CharData = EMail
        Case qkRandom:          CharData = CInt(Rnd() * 100)
        
        Case qkHekau:           Set CharData = HekauList
        Case qkSpells:          Set CharData = SpellList
        Case qkRituals:         Set CharData = RitualList
        Case qkMBalance:        CharData = Balance
        Case qkSekhem:          CharData = Sekhem
        Case qkAmenti:          CharData = Amenti
        Case qkBa:              CharData = Ba
        Case qkKa:              CharData = Ka
        Case qkMemory:          CharData = Memory
        Case qkIntegrity:       CharData = Integrity
        Case qkJoy:             CharData = Joy
        Case qkHumanity:        Set CharData = HumanityList
        Case qkInheritance:     CharData = Inheritance
        Case qkBiography:       CharData = Biography
        Case qkPhysicalMax:     CharData = PhysicalMax
        Case qkSocialMax:       CharData = SocialMax
        Case qkMentalMax:       CharData = MentalMax
        Case qkTempMBalance:    CharData = TempBalance
        Case qkTempSekhem:      CharData = TempSekhem
        Case qkTempBa:          CharData = TempBa
        Case qkTempKa:          CharData = TempKa
        Case qkTempMemory:      CharData = TempMemory
        Case qkTempIntegrity:   CharData = TempIntegrity
        Case qkTempJoy:         CharData = TempJoy
        
        Case Else:              CharData = Null
        
    End Select

End Sub

Public Sub SetValue(Key As String, CharData As Variant)
'
' Name:         SetValue
' Parameters:   Key         a key (string) to the value to set
'               CharData    the new value - a string, number, date or list
' Description:  Use the given key to set data for the character.  Keys are defined
'               in the PublicQueryKeys module.
'

    On Error Resume Next
    
    Select Case Key
        
        Case qkWillpower:       Willpower = CInt(CharData)
        Case qkTempWillpower:   TempWillpower = CInt(CharData)
        Case qkMBalance:        Balance = CInt(CharData)
        Case qkSekhem:          Sekhem = CInt(CharData)
        Case qkBa:              Ba = CInt(CharData)
        Case qkKa:              Ka = CInt(CharData)
        Case qkMemory:          Memory = CInt(CharData)
        Case qkIntegrity:       Integrity = CInt(CharData)
        Case qkJoy:             Joy = CInt(CharData)
        Case qkTempMBalance:    TempBalance = CInt(CharData)
        Case qkTempSekhem:      TempSekhem = CInt(CharData)
        Case qkTempBa:          TempBa = CInt(CharData)
        Case qkTempKa:          TempKa = CInt(CharData)
        Case qkTempMemory:      TempMemory = CInt(CharData)
        Case qkTempIntegrity:   TempIntegrity = CInt(CharData)
        Case qkTempJoy:         TempJoy = CInt(CharData)
        
    End Select

End Sub

Public Sub CompleteEstimateList(Estimate As LinkedTraitList)
'
' Name:         CompleteEstimateList
' Parameter:    Estimate        Traitlist that will hold estimate info
' Description:  Add race-specific entries to a LinkedTraitList for use with the Point Estimate Tool.
'

    Estimate.Append qkMerits
    Estimate.Append qkFlaws
    Estimate.Append qkHekau, , "9"
    Estimate.Append qkRituals, , "6"
    Estimate.Append qkSpells, , "6"
    Estimate.Append qkWillpower, "3", "5"
    Estimate.Append qkSekhem, "3", "1"
    Estimate.Append qkMBalance, "2", Balance
    Estimate.Append qkMemory, "2", Memory
    Estimate.Append qkIntegrity, "2", Integrity
    Estimate.Append qkJoy, "2", Joy
    Estimate.Append qkBa, "2", Ba
    Estimate.Append qkKa, "2", Ka
    
End Sub

Public Function Group() As String
'
' Name:         Group
' Description:  Return the 'Group' this character belongs to.
'               Clan, Tribe, Kith, Guild, etc.
' Returns:      the group
'

    Group = Amenti

End Function

Public Function Subgroup() As String
'
' Name:         Subgroup
' Description:  Return the 'Subgroup' this character belongs to.
'               Sect, Auspice, Seeming, etc.
' Returns:      the subgroup
'

    Subgroup = ""

End Function

Public Function EMail() As String
'
' Name:         EMail
' Description:  Find the player of this character and return its email, if any.
'
    
    EMail = ""
    PlayerList.Memorize
    PlayerList.MoveTo Player
    If Not PlayerList.Off Then EMail = PlayerList.Item.EMail
    PlayerList.Remember

End Function

Public Function ExpandedEMail() As String
'
' Name:         ExpandedEMail
' Description:  Find the player of this character and return its Expanded EMail, if any.
'
    
    ExpandedEMail = ""
    PlayerList.Memorize
    PlayerList.MoveTo Player
    If Not PlayerList.Off Then ExpandedEMail = PlayerList.Item.ExpandedEMail
    PlayerList.Remember

End Function

Public Function Race() As String
'
' Name:         Race
' Description:  Return a string representation of this character's
'               character type.
' Returns:      the name of the character type
'

    Race = "Mummy"

End Function

Public Function RaceCode() As RaceType
'
' Name:         RaceCode
' Description:  Return the RaceType (enumeration value) of this
'               character type.
' Returns:      the corresponding RaceType
'
    
    RaceCode = gvRaceMummy

End Function

Public Sub OutputToFile(XML As XMLWriterClass)
'
' Name:         OutputToFile
' Parameters:   XML     the XMLWriterClass
' Description:  Write this character's data to a file.
'

    With XML
    
        .BeginTag "mummy"
    
            .WriteAttribute "name", Name
            .WriteAttribute "amenti", Amenti
            .WriteAttribute "nature", Nature
            .WriteAttribute "demeanor", Demeanor
            .WriteAttribute "willpower", Willpower
            .WriteAttribute "tempwillpower", TempWillpower, Willpower
            .WriteAttribute "sekhem", Sekhem
            .WriteAttribute "tempsekhem", TempSekhem, Sekhem
            .WriteAttribute "balance", Balance
            .WriteAttribute "tempbalance", TempBalance, Balance
            .WriteAttribute "memory", Memory
            .WriteAttribute "tempmemory", TempMemory, Memory
            .WriteAttribute "integrity", Integrity
            .WriteAttribute "tempintegrity", TempIntegrity, Integrity
            .WriteAttribute "joy", Joy
            .WriteAttribute "tempjoy", TempJoy, Joy
            .WriteAttribute "ba", Ba
            .WriteAttribute "tempba", TempBa, Ba
            .WriteAttribute "ka", Ka
            .WriteAttribute "tempka", TempKa, Ka
            .WriteAttribute "physicalmax", PhysicalMax
            .WriteAttribute "socialmax", SocialMax, PhysicalMax
            .WriteAttribute "mentalmax", MentalMax, PhysicalMax
            .WriteAttribute "player", Player
            .WriteAttribute "status", Status
            .WriteAttribute "id", ID
            .WriteAttribute "startdate", StartDate
            .WriteAttribute "narrator", Narrator
            .WriteAttribute "npc", IsNPC, False
            .WriteAttribute "lastmodified", LastModified
            
            Experience.OutputToFile XML
        
            PhysicalList.OutputToFile XML
            SocialList.OutputToFile XML
            MentalList.OutputToFile XML
            PhysicalNegList.OutputToFile XML
            SocialNegList.OutputToFile XML
            MentalNegList.OutputToFile XML
                
            AbilityList.OutputToFile XML
            InfluenceList.OutputToFile XML
            
            HumanityList.OutputToFile XML
            StatusList.OutputToFile XML
            
            BackgroundList.OutputToFile XML
            HealthList.OutputToFile XML
            
            HekauList.OutputToFile XML
            SpellList.OutputToFile XML
            RitualList.OutputToFile XML
            
            MeritList.OutputToFile XML
            FlawList.OutputToFile XML
            
            EquipmentList.OutputToFile XML
            HangoutList.OutputToFile XML
            
            .WriteCDataTag "inheritance", Inheritance
            .WriteCDataTag "biography", Biography
            .WriteCDataTag "notes", Notes
            
        .EndTag
    
    End With
    
End Sub

Public Sub InputFromFile(XML As XMLReaderClass, Version As Double)
'
' Name:         InputFromFile
' Parameters:   XML             XMLReaderClass that has read the tag
'               Version         file format version
' Description:  Reads the object in from an XML file.
'

    Dim ListName As String
    
    With XML
    
        If .Tag = "mummy" Then
        
            Name = .GetString("name")
            Nature = .GetString("nature")
            Demeanor = .GetString("demeanor")
            Amenti = .GetString("amenti", .GetString("type"))
            Willpower = .GetInteger("willpower")
            TempWillpower = .GetInteger("tempwillpower", Willpower)
            Sekhem = .GetInteger("sekhem")
            TempSekhem = .GetInteger("tempsekhem", Sekhem)
            Balance = .GetInteger("balance")
            TempBalance = .GetInteger("tempbalance", Balance)
            Memory = .GetInteger("memory")
            TempMemory = .GetInteger("tempmemory", Memory)
            Integrity = .GetInteger("integrity")
            TempIntegrity = .GetInteger("tempintegrity", Integrity)
            Joy = .GetInteger("joy")
            TempJoy = .GetInteger("tempjoy", Joy)
            Ba = .GetInteger("ba")
            TempBa = .GetInteger("tempba", Ba)
            Ka = .GetInteger("ka")
            TempKa = .GetInteger("tempka", Ka)
            PhysicalMax = .GetInteger("physicalmax", 11)
            SocialMax = .GetInteger("socialmax", PhysicalMax)
            MentalMax = .GetInteger("mentalmax", PhysicalMax)
            Player = .GetString("player")
            Status = .GetString("status")
            ID = .GetString("id")
            StartDate = .GetDate("startdate")
            Narrator = .GetString("narrator")
            IsNPC = .GetBoolean("npc")
            LastModified = .GetDate("lastmodified")
            
            Do Until .Tag = "mummy" And .Terminal
                .ReadTag
                Select Case .Tag
                    Case "experience"
                        Experience.InputFromFile XML, Version
                    Case "traitlist"
                        ListName = .GetString("name")
                        Select Case ListName
                            Case "Physical":            PhysicalList.InputFromFile XML, Version
                            Case "Social":              SocialList.InputFromFile XML, Version
                            Case "Mental":              MentalList.InputFromFile XML, Version
                            Case "Negative Physical":   PhysicalNegList.InputFromFile XML, Version
                            Case "Negative Social":     SocialNegList.InputFromFile XML, Version
                            Case "Negative Mental":     MentalNegList.InputFromFile XML, Version
                            Case "Abilities":           AbilityList.InputFromFile XML, Version
                            Case "Influences":          InfluenceList.InputFromFile XML, Version
                            Case "Backgrounds":         BackgroundList.InputFromFile XML, Version
                            Case "Health Levels":       HealthList.InputFromFile XML, Version
                            Case "Humanity":            HumanityList.InputFromFile XML, Version
                            Case "Status":              StatusList.InputFromFile XML, Version
                            Case "Hekau":               HekauList.InputFromFile XML, Version
                            Case "Spells":              SpellList.InputFromFile XML, Version
                            Case "Rituals":             RitualList.InputFromFile XML, Version
                            Case "Merits":              MeritList.InputFromFile XML, Version
                            Case "Flaws":               FlawList.InputFromFile XML, Version
                            Case "Equipment":           EquipmentList.InputFromFile XML, Version
                            Case "Locations":           HangoutList.InputFromFile XML, Version
                        End Select
                    Case "inheritance"
                        If Not .Terminal Then
                            .ReadTag
                            Inheritance = .GetTagText
                        End If
                    Case "biography"
                        If Not .Terminal Then
                            .ReadTag
                            Biography = .GetTagText
                        End If
                    Case "notes"
                        If Not .Terminal Then
                            .ReadTag
                            Notes = .GetTagText
                        End If
                End Select
            Loop

            If Version < 2.397 Then
                If PhysicalList.Count > PhysicalMax Then PhysicalMax = PhysicalList.Count
                If SocialList.Count > PhysicalMax Then PhysicalMax = SocialList.Count
                If MentalList.Count > PhysicalMax Then PhysicalMax = MentalList.Count
                SocialMax = PhysicalMax
                MentalMax = PhysicalMax
            End If

        Else
            Err.Raise vbObjectError + 8, "MummyClass", _
                      "Wrong file input to a Mummy character"
        End If
    
    End With
        
End Sub

Public Sub OutputToBinary(FileNum As Integer)
'
' Name:         OutputToBinary
' Parameters:   FileNum     the number of the open file to write to
' Description:  Write this character's data to a binary file.
'

    PutStrB FileNum, Name
    PutStrB FileNum, Amenti
    PutStrB FileNum, Nature
    PutStrB FileNum, Demeanor
    Put #FileNum, , Willpower
    Put #FileNum, , TempWillpower
    Put #FileNum, , Sekhem
    Put #FileNum, , TempSekhem
    Put #FileNum, , Balance
    Put #FileNum, , TempBalance
    Put #FileNum, , Memory
    Put #FileNum, , TempMemory
    Put #FileNum, , Integrity
    Put #FileNum, , TempIntegrity
    Put #FileNum, , Joy
    Put #FileNum, , TempJoy
    Put #FileNum, , Ba
    Put #FileNum, , TempBa
    Put #FileNum, , Ka
    Put #FileNum, , TempKa
    Put #FileNum, , PhysicalMax
    Put #FileNum, , SocialMax
    Put #FileNum, , MentalMax
    PutStrB FileNum, Player
    PutStrB FileNum, Status
    PutStrB FileNum, ID
    Put #FileNum, , StartDate
    PutStrB FileNum, Narrator
    Put #FileNum, , IsNPC
    Put #FileNum, , LastModified
    
    Experience.OutputToBinary FileNum

    PhysicalList.OutputToBinary FileNum
    SocialList.OutputToBinary FileNum
    MentalList.OutputToBinary FileNum
    PhysicalNegList.OutputToBinary FileNum
    SocialNegList.OutputToBinary FileNum
    MentalNegList.OutputToBinary FileNum
        
    AbilityList.OutputToBinary FileNum
    InfluenceList.OutputToBinary FileNum
    
    HumanityList.OutputToBinary FileNum
    StatusList.OutputToBinary FileNum
    
    BackgroundList.OutputToBinary FileNum
    HealthList.OutputToBinary FileNum
    
    HekauList.OutputToBinary FileNum
    SpellList.OutputToBinary FileNum
    RitualList.OutputToBinary FileNum
    
    MeritList.OutputToBinary FileNum
    FlawList.OutputToBinary FileNum
    
    EquipmentList.OutputToBinary FileNum
    HangoutList.OutputToBinary FileNum
    
    PutStrB FileNum, Inheritance
    PutStrB FileNum, Biography
    PutStrB FileNum, Notes

End Sub

Public Sub InputFromBinary(FileNum As Integer, Version As Double)
'
' Name:         InputFromBinary
' Parameters:   FileNum     the number of the open file to read from
'               Version     the version of the file format
' Description:  Read this character's data from a binary file.
'

    GetStrB FileNum, Name
    GetStrB FileNum, Amenti
    GetStrB FileNum, Nature
    GetStrB FileNum, Demeanor
    
    If Version >= 2.397 Then
        Get #FileNum, , Willpower
        Get #FileNum, , TempWillpower
        Get #FileNum, , Sekhem
        Get #FileNum, , TempSekhem
        Get #FileNum, , Balance
        Get #FileNum, , TempBalance
        Get #FileNum, , Memory
        Get #FileNum, , TempMemory
        Get #FileNum, , Integrity
        Get #FileNum, , TempIntegrity
        Get #FileNum, , Joy
        Get #FileNum, , TempJoy
        Get #FileNum, , Ba
        Get #FileNum, , TempBa
        Get #FileNum, , Ka
        Get #FileNum, , TempKa
        Get #FileNum, , PhysicalMax
        Get #FileNum, , SocialMax
        Get #FileNum, , MentalMax
    Else
        Get #FileNum, , Willpower
        Get #FileNum, , Sekhem
        Get #FileNum, , Balance
        Get #FileNum, , Memory
        Get #FileNum, , Integrity
        Get #FileNum, , Joy
        Get #FileNum, , Ba
        Get #FileNum, , Ka
        TempWillpower = Willpower
        TempSekhem = Sekhem
        TempBalance = Balance
        TempMemory = Memory
        TempIntegrity = Integrity
        TempJoy = Joy
        TempBa = Ba
        TempKa = Ka
    End If
    
    GetStrB FileNum, Player
    GetStrB FileNum, Status
    GetStrB FileNum, ID
    If Version >= 2.397 Then
        Get #FileNum, , StartDate
    Else
        GetStrB FileNum, Narrator 'Use temporarily to convert from old string format
        If IsDate(Narrator) Then StartDate = CDate(Narrator)
    End If
    GetStrB FileNum, Narrator
    Get #FileNum, , IsNPC
    Get #FileNum, , LastModified
    
    Experience.InputFromBinary FileNum, Version

    PhysicalList.InputFromBinary FileNum, Version
    SocialList.InputFromBinary FileNum, Version
    MentalList.InputFromBinary FileNum, Version
    PhysicalNegList.InputFromBinary FileNum, Version
    SocialNegList.InputFromBinary FileNum, Version
    MentalNegList.InputFromBinary FileNum, Version
        
    AbilityList.InputFromBinary FileNum, Version
    InfluenceList.InputFromBinary FileNum, Version
    
    HumanityList.InputFromBinary FileNum, Version
    StatusList.InputFromBinary FileNum, Version
    
    BackgroundList.InputFromBinary FileNum, Version
    HealthList.InputFromBinary FileNum, Version
    
    HekauList.InputFromBinary FileNum, Version
    SpellList.InputFromBinary FileNum, Version
    RitualList.InputFromBinary FileNum, Version
    
    MeritList.InputFromBinary FileNum, Version
    FlawList.InputFromBinary FileNum, Version
    
    EquipmentList.InputFromBinary FileNum, Version
    If Version >= 2.395 Then HangoutList.InputFromBinary FileNum, Version
    
    GetStrB FileNum, Inheritance
    If Version >= 2.397 Then GetStrB FileNum, Biography
    GetStrB FileNum, Notes

    If Version < 2.397 Then
        If PhysicalList.Count > PhysicalMax Then PhysicalMax = PhysicalList.Count
        If SocialList.Count > PhysicalMax Then PhysicalMax = SocialList.Count
        If MentalList.Count > PhysicalMax Then PhysicalMax = MentalList.Count
        SocialMax = PhysicalMax
        MentalMax = PhysicalMax
    End If
    
End Sub

Public Sub OldInputFromFile(FileNum As Integer, OldDate As Date, Version As String)
'
' Name:         OldInputFromFile
' Parameters:   FileNum         number of an open file
'               Version         file format version of the file
' Description:  Read a character from an input file.  The version
'               ensures backward-compatibility.
'

    Dim Read As String
    
    ' Race has already been read
    Line Input #FileNum, Name
    Line Input #FileNum, Amenti
    Line Input #FileNum, Nature
    Line Input #FileNum, Demeanor
    
    Line Input #FileNum, Read
    Willpower = Val(Read)
    TempWillpower = Willpower
    Line Input #FileNum, Read
    Memory = Val(Read)
    TempMemory = Memory
    Line Input #FileNum, Read
    Integrity = Val(Read)
    TempIntegrity = Integrity
    Line Input #FileNum, Read
    Joy = Val(Read)
    TempJoy = Joy
    Line Input #FileNum, Read
    Ba = Val(Read)
    TempBa = Ba
    Line Input #FileNum, Read
    Ka = Val(Read)
    TempKa = Ka
    Line Input #FileNum, Read
    Sekhem = Val(Read)
    TempSekhem = Sekhem
    
    PhysicalList.OldInputFromFile FileNum, Version
    SocialList.OldInputFromFile FileNum, Version
    MentalList.OldInputFromFile FileNum, Version
    PhysicalNegList.OldInputFromFile FileNum, Version
    SocialNegList.OldInputFromFile FileNum, Version
    MentalNegList.OldInputFromFile FileNum, Version
    
    AbilityList.OldInputFromFile FileNum, Version
    InfluenceList.OldInputFromFile FileNum, Version
    
    HumanityList.OldInputFromFile FileNum, Version
    StatusList.OldInputFromFile FileNum, Version
    
    BackgroundList.OldInputFromFile FileNum, Version
    HealthList.OldInputFromFile FileNum, Version
    
    HekauList.LLInputFromFile FileNum, Version
        
    MeritList.LLInputFromFile FileNum, Version
    FlawList.LLInputFromFile FileNum, Version
    
    Notes = ""
    Read = ReadLongField(FileNum, "<-End Mummy Character Equipment->")
    If Read <> "" Then Notes = "2.3 Equipment:" & vbCrLf & Read & vbCrLf
    Notes = Notes & ReadLongField(FileNum, "<-End Mummy Character Notes->")
    
    If PhysicalList.Count > PhysicalMax Then PhysicalMax = PhysicalList.Count
    If SocialList.Count > PhysicalMax Then PhysicalMax = SocialList.Count
    If MentalList.Count > PhysicalMax Then PhysicalMax = MentalList.Count
    SocialMax = PhysicalMax
    MentalMax = PhysicalMax
    
    Line Input #FileNum, Player
    Line Input #FileNum, Read
    Experience.Unspent = Val(Read)
    Experience.Earned = Val(Read)
    Line Input #FileNum, Status
    Line Input #FileNum, ID
    Line Input #FileNum, Narrator
    If IsDate(Narrator) Then StartDate = CDate(Narrator)
    Line Input #FileNum, Narrator
    Line Input #FileNum, Read
    IsNPC = CBool(Read)
    Experience.OldInputFromFile FileNum, Version
    LastModified = OldDate

End Sub

Private Sub Class_Initialize()
'
' Name:         Class_Initialize
' Description:  Intialize all data to defaults.
'

    Willpower = 5
    Sekhem = 1
    Balance = 1
    Memory = 1
    Integrity = 1
    Joy = 1
    Ba = 5
    Ka = 5
    TempWillpower = 5
    TempSekhem = 1
    TempBalance = 1
    TempMemory = 1
    TempIntegrity = 1
    TempJoy = 1
    TempBa = 5
    TempKa = 5
    PhysicalMax = 11
    SocialMax = 11
    MentalMax = 11
    
    Status = ActiveStatus
    StartDate = Now
    LastModified = Now

    Set PhysicalList = New LinkedTraitList
    Set SocialList = New LinkedTraitList
    Set MentalList = New LinkedTraitList
    Set PhysicalNegList = New LinkedTraitList
    Set SocialNegList = New LinkedTraitList
    Set MentalNegList = New LinkedTraitList
        
    Set AbilityList = New LinkedTraitList
    Set InfluenceList = New LinkedTraitList
    
    Set HumanityList = New LinkedTraitList
    Set StatusList = New LinkedTraitList

    Set BackgroundList = New LinkedTraitList
    Set HealthList = New LinkedTraitList
    Set HekauList = New LinkedTraitList
    Set SpellList = New LinkedTraitList
    Set RitualList = New LinkedTraitList
    
    Set MeritList = New LinkedTraitList
    Set FlawList = New LinkedTraitList
    
    Set EquipmentList = New LinkedTraitList
    Set HangoutList = New LinkedTraitList
    Set Experience = New ExperienceClass
    
    PhysicalList.Initialize "Physical", True, False, False, ldMultiplier
    SocialList.Initialize "Social", True, False, False, ldMultiplier
    MentalList.Initialize "Mental", True, False, False, ldMultiplier
    PhysicalNegList.Initialize "Negative Physical", True, True, False, ldMultiplier
    SocialNegList.Initialize "Negative Social", True, True, False, ldMultiplier
    MentalNegList.Initialize "Negative Mental", True, True, False, ldMultiplier
    
    AbilityList.Initialize "Abilities", True, False, False, ldMultiplier
    InfluenceList.Initialize "Influences", True, False, False, ldMultiplier
    BackgroundList.Initialize "Backgrounds", True, False, False, ldMultiplier
    HealthList.Initialize "Health Levels", False, False, False, ldMultiplier
    
    HumanityList.Initialize "Humanity", True, False, False, ldMultiplier
    StatusList.Initialize "Status", True, False, False, ldMultiplier
    HekauList.Initialize "Hekau", False, False, True, ldNoteOnly
    SpellList.Initialize "Spells", False, False, True, ldNoteOnly
    RitualList.Initialize "Rituals", False, False, True, ldNoteOnly
    
    MeritList.Initialize "Merits", True, False, True, ldCost
    FlawList.Initialize "Flaws", True, True, True, ldCost
    
    EquipmentList.Initialize "Equipment", True, False, False, ldMultiplier
    HangoutList.Initialize "Locations", True, False, True, ldNoteOnly
    
    With HealthList
        .Append StdHealth(0)
        .Append StdHealth(1)
        .Append StdHealth(2)
        .Append StdHealth(3)
        .Append StdHealth(4)
        .Append "Dead"
        .Append "Dead"
        If Game.ExtendedHealth Then
            .Append StdHealth(0)
            .Append StdHealth(1)
            .Append StdHealth(1)
            .Append StdHealth(2)
        End If
    End With
    
End Sub

Private Sub Class_Terminate()
'
' Name:         Class_Terminate
' Description:  Destroy all objects created in this class.
'

    Set PhysicalList = Nothing
    Set SocialList = Nothing
    Set MentalList = Nothing
    Set PhysicalNegList = Nothing
    Set SocialNegList = Nothing
    Set MentalNegList = Nothing

    Set AbilityList = Nothing
    Set InfluenceList = Nothing

    Set HumanityList = Nothing
    Set StatusList = Nothing

    Set BackgroundList = Nothing
    Set HealthList = Nothing
    Set HekauList = Nothing
    Set SpellList = Nothing
    Set RitualList = Nothing

    Set MeritList = Nothing
    Set FlawList = Nothing

    Set EquipmentList = Nothing
    Set HangoutList = Nothing
    Set Experience = Nothing

End Sub
