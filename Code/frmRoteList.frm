VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmRoteList 
   Caption         =   "Rotes"
   ClientHeight    =   5070
   ClientLeft      =   1875
   ClientTop       =   750
   ClientWidth     =   7605
   Icon            =   "frmRoteList.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5070
   ScaleWidth      =   7605
   Begin VB.Frame fraRight 
      BorderStyle     =   0  'None
      Height          =   4335
      Left            =   5640
      TabIndex        =   2
      Top             =   480
      Width           =   1695
      Begin VB.ComboBox cboSpheres 
         Height          =   315
         ItemData        =   "frmRoteList.frx":058A
         Left            =   0
         List            =   "frmRoteList.frx":05AC
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   4020
         Width           =   1695
      End
      Begin VB.CommandButton cmdAddNew 
         Caption         =   "&Add New Rote"
         Height          =   375
         Left            =   0
         TabIndex        =   8
         Top             =   3000
         Width           =   1695
      End
      Begin VB.CommandButton cmdShow 
         Caption         =   "&Show Rote"
         Default         =   -1  'True
         Height          =   375
         Left            =   0
         TabIndex        =   7
         Top             =   2040
         Width           =   1695
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "&Delete Rote"
         Height          =   375
         Left            =   0
         TabIndex        =   9
         Top             =   3480
         Width           =   1695
      End
      Begin VB.Label lblLabels 
         Alignment       =   2  'Center
         Caption         =   "Last Modified:"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   5
         Top             =   1320
         Width           =   1455
      End
      Begin VB.Label lblDate 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Image imgIcon 
         Height          =   480
         Left            =   607
         Picture         =   "frmRoteList.frx":0605
         Tag             =   "11"
         Top             =   120
         Visible         =   0   'False
         Width           =   480
      End
      Begin VB.Label lblName 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   120
         TabIndex        =   4
         Top             =   660
         Width           =   1455
      End
      Begin VB.Label lblLabels 
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Height          =   1935
         Index           =   2
         Left            =   0
         TabIndex        =   3
         Top             =   0
         Width           =   1695
      End
   End
   Begin MSComctlLib.ListView lvwList 
      Height          =   4335
      Left            =   240
      TabIndex        =   1
      Top             =   480
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   7646
      View            =   3
      LabelEdit       =   1
      Sorted          =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   2
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Key             =   "name"
         Text            =   "Name"
         Object.Width           =   7594
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Key             =   "level"
         Text            =   "Level"
         Object.Width           =   1005
      EndProperty
   End
   Begin VB.CommandButton cmdESCClose 
      Cancel          =   -1  'True
      Height          =   255
      Left            =   -360
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   0
      Width           =   255
   End
   Begin VB.Label lblCount 
      Alignment       =   2  'Center
      Caption         =   "0 &Rotes"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   5175
   End
End
Attribute VB_Name = "frmRoteList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'
' Name:         frmRoteList
' Description:  Manage the game's list of items.
'
Private ShiftDown As Boolean

Private Const FORM_START_HEIGHT = 5475
Private Const FORM_START_WIDTH = 7740
Private Const FORM_MIN_SCALEHEIGHT = 5070
Private Const FORM_MIN_SCALEWIDTH = 4005
Private Const BOTTOM_MARGIN = 255
Private Const RIGHT_MARGIN = 1980
Private Const VERTICAL_GAP = 225
Private Const LIST_SCROLL_WIDTH = 300

Private Sub RefreshList()
'
' Name:         RefreshList
' Description:  Preserving the current selection, this refills the list box from the list of
'               rotes according to the chosen search.
'

    Dim StoreSelKey As String
    Dim StoreSelIndex As Integer
    Dim Rote As RoteClass
    Dim NewRote As ListItem
    Dim IconKey As String
    Dim Results As LinkedList
    
    Screen.MousePointer = vbHourglass
    
    If Not (lvwList.SelectedItem Is Nothing) Then
        StoreSelKey = lvwList.SelectedItem.Key
        StoreSelIndex = lvwList.SelectedItem.Index
    End If
    
    lvwList.ListItems.Clear
    
    If cboSpheres.Text = "All Rotes" Then
        Set Results = RoteList
    Else
    
        Dim Q As QueryClass
        Set Q = New QueryClass
        
        Q.Inventory = qiRotes
        Q.MatchAll = False
        
        Q.AddClause qkSpheres, cboSpheres.Text, 0, qcContains, False
        If cboSpheres.Text = "Spirit" Then _
            Q.AddClause qkSpheres, "Dimensional Science", 0, qcContains, False
        
        Game.QueryEngine.MakeQuery Q
        
        Set Results = Game.QueryEngine.Results
        Set Q = Nothing
        
    End If
        
    Results.First
    Do Until Results.Off
        Set Rote = Results.Item
        Set NewRote = lvwList.ListItems.Add(, "key" & Rote.Name, Rote.Name, , Rote.IconKey)
        NewRote.ListSubItems.Add , "level", "  " & CStr(Rote.Level)
        Results.MoveNext
    Loop
    
    lblCount.Caption = CStr(Results.Count) & " &Rotes"
    
    On Error Resume Next
    Set lvwList.SelectedItem = lvwList.ListItems(StoreSelKey)
    If lvwList.SelectedItem Is Nothing And lvwList.ListItems.Count > 0 Then
        If StoreSelIndex > lvwList.ListItems.Count Then StoreSelIndex = lvwList.ListItems.Count
        Set lvwList.SelectedItem = lvwList.ListItems(StoreSelIndex)
        If lvwList.SelectedItem Is Nothing Then Set lvwList.SelectedItem = lvwList.GetFirstVisible
    End If
    lvwList.SelectedItem.EnsureVisible
    On Error GoTo 0

    lvwList_ItemClick lvwList.SelectedItem

    Set Results = Nothing

    Screen.MousePointer = vbDefault

End Sub

Public Sub SetDefaultOutput()
'
' Name:         SetDefaultOutput
' Description:  Initilize the OutputEngineClass with default output settings.
'
    With OutputEngine
        .Template = tnRoteCards
        .SelectSet(osRotes).Clear
        .SelectSet(osRotes).StoreListView lvwList, True
        .GameDate = 0
    End With
    
End Sub

Private Sub cboSpheres_Click()
'
' Name:         cboSpheres_Click
' Description:  Refresh the list of rotes.
'

    RefreshList

End Sub

Private Sub cmdAddNew_Click()
'
' Name:         cmdAddNew_Click
' Description:  Calls on Creates the appropriate rote and
'               adds it to the linked list and the list box, selecting it.
'

    Dim NewRote As RoteClass
    Dim NewName As String
    Dim I As Integer
    Dim HasInList As Boolean
    
    Do
        NewName = InputBox("Enter a name for the rote:", "New Rote")
        NewName = Trim(NewName)
        If NewName = "" Then Exit Do
        RoteList.MoveTo NewName
    Loop Until RoteList.Off
    
    If NewName <> "" Then
    
        Set NewRote = New RoteClass
        NewRote.Name = NewName
        RoteList.InsertSorted NewRote
        
        mdiMain.AnnounceChanges Me, atRotes
        Game.DataChanged = True
        RefreshList
    
        On Error Resume Next
        Set lvwList.SelectedItem = lvwList.ListItems("key" & NewName)
        lvwList.SelectedItem.EnsureVisible
        HasInList = (NewName = lvwList.SelectedItem.Text)
        On Error GoTo 0
    
        If HasInList Then
            lvwList.SetFocus
        Else
            mdiMain.ShowRote NewName
        End If

    End If

End Sub

Private Sub cmdDelete_Click()
'
' Name:         cmdDelete_Click
' Description:  Finds the character and asks confirmation of deletion.  If yes, remove the character
'               and refill the list.
'

    Dim NormForm As Form
    Dim DelName As String
    Dim Answer As Boolean
    
    If Not (lvwList.SelectedItem Is Nothing) Then
        DelName = lvwList.SelectedItem.Text
        RoteList.MoveTo DelName
        If Not RoteList.Off Then
        
            Answer = ShiftDown
            If Not Answer Then Answer = (MsgBox("This will PERMANENTLY remove " & DelName & _
                    " from the game. Are you sure you want to delete this rote?", _
                    vbYesNo + vbQuestion, "Delete Rote") = vbYes)
            If Answer Then
                    
                mdiMain.AnnounceChanges Me, atRotes
                Game.DataChanged = True
    
                For Each NormForm In Forms()
                    If NormForm.Caption = DelName And NormForm.Tag = "R" Then
                        Unload NormForm
                        Exit For
                    End If
                Next NormForm
                
                RoteList.Remove
                RefreshList
                
            End If
        Else
            MsgBox "Grapevine can't find this rote!  Was it renamed or deleted?", vbExclamation
        End If
    End If

End Sub

Private Sub cmdESCClose_Click()
'
' Name:         cmdESCClose_Click
' Description:  Close the window when the user presses ESC.
'

    Unload Me

End Sub

Private Sub cmdShow_Click()
'
' Name:         cmdShow_Click
' Description:  Asks the parent form to create a character sheet screen for the selected character.
'

    If Not (lvwList.SelectedItem Is Nothing) Then _
        mdiMain.ShowRote lvwList.SelectedItem.Text

End Sub

Private Sub Form_Activate()
'
' Name:         Form_Activate
' Description:  If the characters have changed, refresh the list.
'

    If mdiMain.CheckForChanges(Me, atRotes) Then
        RefreshList
    Else
        lvwList_ItemClick lvwList.SelectedItem
    End If

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
'
' Name:         Form_KeyDown
' Description:  Record the state of the Shift key for deletions.
'

    If KeyCode = vbKeyShift Then ShiftDown = True

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
'
' Name:         Form_KeyDown
' Description:  Record the state of the Shift key for deletions.
'

    If KeyCode = vbKeyShift Then ShiftDown = False
    If KeyCode = vbKeyDelete Then Call cmdDelete_Click

End Sub

Private Sub Form_Load()
'
' Name:         Form_Load
' Description:  Fill the list and select the first character.
'
    
    Me.Width = FORM_START_WIDTH
    Me.Height = FORM_START_HEIGHT
    
    Set lvwList.SmallIcons = mdiMain.imlSmallIcons
    
    cboSpheres.ListIndex = 0
    
End Sub

Private Sub Form_Resize()
'
' Name:         Form_Resize
' Description:  Position the controls appropriately on a resized form.
'

    Dim SH As Integer
    Dim SW As Integer
    
    If Me.WindowState <> vbMinimized Then
        
        SH = Me.ScaleHeight
        SW = Me.ScaleWidth
    
        If SH < FORM_MIN_SCALEHEIGHT Then SH = FORM_MIN_SCALEHEIGHT
        If SW < FORM_MIN_SCALEWIDTH Then SW = FORM_MIN_SCALEWIDTH
    
        fraRight.Left = SW - RIGHT_MARGIN
        lvwList.Height = SH - lvwList.Top - BOTTOM_MARGIN
        lvwList.Width = SW - lvwList.Left - RIGHT_MARGIN - VERTICAL_GAP
        lblCount.Width = lvwList.Width

    End If

End Sub

Private Sub lvwList_ColumnClick(ByVal ColumnHeader As MSComctlLib.ColumnHeader)
'
' Name:         lvwList_ColumnClick
' Description:  Change the key by which the entries are sorted, or the sort order on a second click.
'
    
    If lvwList.SortKey = ColumnHeader.Index - 1 Then
        lvwList.SortOrder = IIf(lvwList.SortOrder = lvwAscending, lvwDescending, lvwAscending)
    Else
        lvwList.SortKey = ColumnHeader.Index - 1
    End If

End Sub

Private Sub lvwList_DblClick()
'
' Name:         lstCharacters_DblClick
' Description:  See cmdShow_Click.
'

    Call cmdShow_Click

End Sub

Private Sub lvwList_ItemClick(ByVal Item As MSComctlLib.ListItem)
'
' Name:         lstCharacters_ItemClick
' Description:  Find the character and display the appropriate information at right.
'

    If Not (Item Is Nothing) Then
        RoteList.MoveTo Item.Text
        If Not RoteList.Off Then
            imgIcon.Picture = mdiMain.imlIcons.ListImages(RoteList.Item.IconKey).Picture
            imgIcon.Visible = True
            lblName.Caption = Item.Text
            lblDate.Caption = Format(RoteList.Item.LastModified, "Short Date")
        Else
            MsgBox "Grapevine can't find this rote!  Was it renamed or deleted?", vbExclamation
        End If
    Else
        imgIcon.Visible = False
        lblName.Caption = ""
        lblDate.Caption = ""
    End If

End Sub
