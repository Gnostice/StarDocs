object Form1: TForm1
  Left = 457
  Top = 193
  BorderStyle = bsSingle
  Caption = 'Gnostice StarDocs  Delphi SDK  Demo'
  ClientHeight = 575
  ClientWidth = 575
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    575
    575)
  PixelsPerInch = 96
  TextHeight = 13
  object Label18: TLabel
    Left = 8
    Top = 8
    Width = 297
    Height = 29
    Caption = 'Choose document operation'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pgeCntrlDocoperation: TPageControl
    Left = 8
    Top = 43
    Width = 575
    Height = 540
    ActivePage = tbshDocInfo
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitWidth = 562
    ExplicitHeight = 541
    object tbshView: TTabSheet
      Caption = 'View'
      ExplicitWidth = 554
      ExplicitHeight = 513
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 567
        Height = 512
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 554
        ExplicitHeight = 513
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 565
          Height = 41
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 552
          object Label31: TLabel
            Left = 13
            Top = 16
            Width = 43
            Height = 13
            Caption = 'Input file'
          end
          object btnViewLoad: TButton
            Left = 325
            Top = 11
            Width = 35
            Height = 25
            Caption = '...'
            TabOrder = 0
            OnClick = btnViewLoadClick
          end
          object edViewLoad: TEdit
            Left = 81
            Top = 15
            Width = 240
            Height = 21
            TabOrder = 1
          end
          object btnView: TButton
            Left = 366
            Top = 11
            Width = 75
            Height = 25
            Caption = 'View'
            Enabled = False
            TabOrder = 2
            OnClick = btnViewClick
          end
        end
        object Panel2: TPanel
          Left = 1
          Top = 42
          Width = 565
          Height = 469
          Align = alClient
          TabOrder = 1
          ExplicitWidth = 552
          ExplicitHeight = 470
          object WebBrowser1: TWebBrowser
            Left = 1
            Top = 1
            Width = 563
            Height = 467
            Align = alClient
            TabOrder = 0
            ExplicitLeft = -5
            ExplicitWidth = 550
            ExplicitHeight = 468
            ControlData = {
              4C000000303A0000443000000000000000000000000000000000000000000000
              000000004C000000000000000000000001000000E0D057007335CF11AE690800
              2B2E126208000000000000004C0000000114020000000000C000000000000046
              8000000000000000000000000000000000000000000000000000000000000000
              00000000000000000100000000000000000000000000000000000000}
          end
        end
      end
    end
    object tbshSplit: TTabSheet
      Caption = 'Split'
      ImageIndex = 1
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox9: TGroupBox
        Left = 3
        Top = 3
        Width = 419
        Height = 132
        Caption = 'Split '
        TabOrder = 0
        object Label21: TLabel
          Left = 13
          Top = 18
          Width = 43
          Height = 13
          Caption = 'Input file'
        end
        object Label22: TLabel
          Left = 13
          Top = 47
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object Label9: TLabel
          Left = 160
          Top = 47
          Width = 55
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object Label5: TLabel
          Left = 13
          Top = 73
          Width = 51
          Height = 13
          Caption = 'Output file'
        end
        object edSplitLoad: TEdit
          Left = 74
          Top = 20
          Width = 240
          Height = 21
          TabOrder = 0
        end
        object edPageRange: TEdit
          Left = 73
          Top = 47
          Width = 80
          Height = 21
          TabOrder = 1
          Text = '1'
        end
        object btnSplitByRange: TButton
          Left = 94
          Top = 104
          Width = 121
          Height = 25
          Caption = 'Split by page range'
          Enabled = False
          TabOrder = 2
          OnClick = btnSplitByRangeClick
        end
        object btnSplitload: TButton
          Left = 320
          Top = 18
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 3
          OnClick = btnSplitloadClick
        end
        object edSplitOutput: TEdit
          Left = 73
          Top = 74
          Width = 240
          Height = 21
          TabOrder = 4
        end
        object btnSplitSave: TButton
          Left = 319
          Top = 73
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 5
        end
        object btnSplitBySeperator: TButton
          Left = 240
          Top = 104
          Width = 113
          Height = 25
          Caption = 'Split by seperator'
          Enabled = False
          TabOrder = 6
          OnClick = btnSplitBySeperatorClick
        end
      end
    end
    object tbshConvert: TTabSheet
      Caption = 'Convert'
      ImageIndex = 2
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox2: TGroupBox
        Left = 3
        Top = 3
        Width = 491
        Height = 184
        Caption = 'Convert documents'
        TabOrder = 0
        object Label2: TLabel
          Left = 11
          Top = 25
          Width = 56
          Height = 13
          Caption = 'Input file(s)'
        end
        object Label3: TLabel
          Left = 11
          Top = 95
          Width = 51
          Height = 13
          Caption = 'Output file'
        end
        object Label6: TLabel
          Left = 11
          Top = 60
          Width = 69
          Height = 13
          Caption = 'Output format'
        end
        object Label8: TLabel
          Left = 253
          Top = 60
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object Label10: TLabel
          Left = 400
          Top = 60
          Width = 55
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object btnConvertload: TButton
          Left = 370
          Top = 25
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnClick = btnConvertloadClick
        end
        object btnConvert: TButton
          Left = 330
          Top = 142
          Width = 75
          Height = 25
          Caption = 'Convert'
          Enabled = False
          TabOrder = 1
          OnClick = btnConvertClick
        end
        object edConvertLoad: TEdit
          Left = 86
          Top = 25
          Width = 275
          Height = 21
          TabOrder = 2
        end
        object edConvertoutput: TEdit
          Left = 86
          Top = 95
          Width = 275
          Height = 21
          TabOrder = 3
        end
        object btnConvertsave: TButton
          Left = 370
          Top = 95
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 4
        end
        object ComboBox1: TComboBox
          Left = 86
          Top = 60
          Width = 129
          Height = 21
          ItemIndex = 0
          TabOrder = 5
          Text = 'PDF'
          Items.Strings = (
            'PDF'
            'Single-Page TIFF'
            'Multi-Page TIFF'
            'JPEG'
            'GIF'
            'PNG'
            'BMP')
        end
        object edConvertpagerange: TEdit
          Left = 314
          Top = 60
          Width = 80
          Height = 21
          TabOrder = 6
          Text = '1'
        end
      end
    end
    object tbshEncrypt: TTabSheet
      Caption = 'Encrypt'
      ImageIndex = 3
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox4: TGroupBox
        Left = 3
        Top = 3
        Width = 475
        Height = 507
        Caption = 'Encrypt document'
        TabOrder = 0
        object Label12: TLabel
          Left = 13
          Top = 18
          Width = 43
          Height = 13
          Caption = 'Input file'
        end
        object Label13: TLabel
          Left = 13
          Top = 425
          Width = 51
          Height = 13
          Caption = 'Output file'
        end
        object edEncryptLoad: TEdit
          Left = 75
          Top = 18
          Width = 304
          Height = 21
          TabOrder = 0
        end
        object btnEncrypt: TButton
          Left = 352
          Top = 462
          Width = 75
          Height = 25
          Caption = 'Encrypt'
          Enabled = False
          TabOrder = 1
          OnClick = btnEncryptClick
        end
        object btnEncryptLoad: TButton
          Left = 394
          Top = 18
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 2
          OnClick = btnEncryptLoadClick
        end
        object edEncryptOutput: TEdit
          Left = 75
          Top = 425
          Width = 304
          Height = 21
          TabOrder = 3
        end
        object btnEncryptSave: TButton
          Left = 394
          Top = 425
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 4
        end
        object gbEncryption: TGroupBox
          Left = 75
          Top = 48
          Width = 355
          Height = 361
          TabOrder = 5
          object lblConfirmOwnerPswd: TLabel
            Left = 18
            Top = 52
            Width = 119
            Height = 13
            Caption = 'Confirm owner password'
          end
          object lblUserPswd: TLabel
            Left = 18
            Top = 81
            Width = 71
            Height = 13
            Caption = 'User password'
          end
          object lblConfirmUserPswd: TLabel
            Left = 18
            Top = 111
            Width = 110
            Height = 13
            Caption = 'Confirm user password'
          end
          object lblOwnerPswd: TLabel
            Left = 18
            Top = 21
            Width = 81
            Height = 13
            Caption = 'Owner password'
          end
          object rgEncryptionLevel: TRadioGroup
            Left = 16
            Top = 134
            Width = 321
            Height = 55
            Caption = 'Encryption level'
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              'None'
              'AES - 128 Bit'
              'RC4 - 128 Bit'
              'RC4 - 40 Bit')
            TabOrder = 0
          end
          object gbUserPermissions: TGroupBox
            Left = 16
            Top = 195
            Width = 321
            Height = 150
            Caption = 'User permissions'
            TabOrder = 1
            object chklstUserPermissions: TCheckListBox
              Left = 3
              Top = 23
              Width = 301
              Height = 114
              ItemHeight = 13
              Items.Strings = (
                'Print'
                'Modify'
                'Copy'
                'Annotation'
                'Formfill'
                'Accessibilty'
                'Document assembly'
                'High resolution printing')
              TabOrder = 0
            end
          end
          object edtOwnerPassword: TEdit
            Left = 165
            Top = 16
            Width = 172
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object edtConfirmOwnerPassword: TEdit
            Left = 165
            Top = 47
            Width = 172
            Height = 21
            PasswordChar = '*'
            TabOrder = 3
          end
          object edtUserPassword: TEdit
            Left = 165
            Top = 78
            Width = 172
            Height = 21
            PasswordChar = '*'
            TabOrder = 4
          end
          object edtConfirmUserPassword: TEdit
            Left = 165
            Top = 107
            Width = 172
            Height = 21
            PasswordChar = '*'
            TabOrder = 5
          end
        end
      end
    end
    object tbshRedactText: TTabSheet
      Caption = 'Redact text'
      ImageIndex = 4
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox5: TGroupBox
        Left = 3
        Top = 3
        Width = 539
        Height = 156
        Caption = 'Redact text'
        TabOrder = 0
        object Label15: TLabel
          Left = 13
          Top = 48
          Width = 56
          Height = 13
          Caption = 'Search text'
        end
        object Label17: TLabel
          Left = 13
          Top = 78
          Width = 51
          Height = 13
          Caption = 'Output file'
        end
        object Label16: TLabel
          Left = 243
          Top = 48
          Width = 61
          Height = 13
          Caption = 'Replace text'
        end
        object Label7: TLabel
          Left = 13
          Top = 18
          Width = 43
          Height = 13
          Caption = 'Input file'
        end
        object edSearchText: TEdit
          Left = 77
          Top = 48
          Width = 160
          Height = 21
          TabOrder = 0
        end
        object btnRedact: TButton
          Left = 461
          Top = 128
          Width = 75
          Height = 25
          Caption = 'Redact'
          Enabled = False
          TabOrder = 1
          OnClick = btnRedactClick
        end
        object edRedactOutput: TEdit
          Left = 77
          Top = 78
          Width = 401
          Height = 21
          TabOrder = 2
        end
        object btnRedactSave: TButton
          Left = 495
          Top = 78
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 3
        end
        object edReplaceText: TEdit
          Left = 318
          Top = 48
          Width = 160
          Height = 21
          TabOrder = 4
          Text = 'XXXX'
        end
        object btnRedactLoad: TButton
          Left = 495
          Top = 18
          Width = 35
          Height = 25
          Caption = '...'
          Enabled = False
          TabOrder = 5
          OnClick = btnRedactLoadClick
        end
        object edReadctLoad: TEdit
          Left = 77
          Top = 18
          Width = 401
          Height = 21
          TabOrder = 6
        end
      end
    end
    object tbshMerge: TTabSheet
      Caption = 'Merge'
      ImageIndex = 5
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 406
        Height = 123
        Caption = 'Merge documents'
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 24
          Width = 56
          Height = 13
          Caption = 'Input file(s)'
        end
        object Label4: TLabel
          Left = 11
          Top = 59
          Width = 51
          Height = 13
          Caption = 'Output file'
        end
        object btnMergeLoad: TButton
          Left = 367
          Top = 24
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnClick = btnMergeOpen1Click
        end
        object btnMerge: TButton
          Left = 296
          Top = 86
          Width = 75
          Height = 25
          Caption = 'Merge '
          Enabled = False
          TabOrder = 1
          OnClick = btnMergeClick
        end
        object edMergeLoad: TEdit
          Left = 70
          Top = 24
          Width = 291
          Height = 21
          TabOrder = 2
        end
        object edMergeoutput: TEdit
          Left = 70
          Top = 56
          Width = 291
          Height = 21
          TabOrder = 3
        end
        object btnMergeSave: TButton
          Left = 367
          Top = 59
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 4
        end
      end
    end
    object tbshDocInfo: TTabSheet
      Caption = 'Document Info'
      ImageIndex = 6
      ExplicitWidth = 554
      ExplicitHeight = 513
      object GroupBox6: TGroupBox
        Left = 3
        Top = 3
        Width = 551
        Height = 73
        Caption = 'Document info'
        TabOrder = 0
        object Label29: TLabel
          Left = 17
          Top = 16
          Width = 43
          Height = 13
          Caption = 'Input file'
        end
        object btnGetInfo: TButton
          Left = 459
          Top = 47
          Width = 75
          Height = 25
          Caption = 'Get info'
          Enabled = False
          TabOrder = 0
          OnClick = btnGetInfoClick
        end
        object btnDocInfoload: TButton
          Left = 501
          Top = 16
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 1
          OnClick = btnDocInfoloadClick
        end
        object edDocInfoLoad: TEdit
          Left = 90
          Top = 16
          Width = 389
          Height = 21
          TabOrder = 2
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 82
        Width = 551
        Height = 361
        TabOrder = 1
        Visible = False
        object Label19: TLabel
          Left = 147
          Top = 40
          Width = 45
          Height = 13
          Caption = 'File name'
        end
        object Label20: TLabel
          Left = 155
          Top = 80
          Width = 37
          Height = 13
          Caption = 'File size'
        end
        object Label23: TLabel
          Left = 16
          Top = 160
          Width = 178
          Height = 13
          Caption = 'Is unsupported MIME type or corrupt'
        end
        object Label24: TLabel
          Left = 96
          Top = 280
          Width = 95
          Height = 13
          Caption = 'Is password correct'
        end
        object Label25: TLabel
          Left = 132
          Top = 120
          Width = 54
          Height = 13
          Caption = 'Page count'
        end
        object Label26: TLabel
          Left = 88
          Top = 240
          Width = 108
          Height = 13
          Caption = 'Is password protected'
        end
        object Label27: TLabel
          Left = 140
          Top = 200
          Width = 51
          Height = 13
          Caption = 'MIME type'
        end
        object edFileName: TEdit
          Left = 199
          Top = 40
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object edIsCorrupt: TEdit
          Left = 199
          Top = 160
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object edFileSize: TEdit
          Left = 199
          Top = 80
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 2
        end
        object edISPasswordProtected: TEdit
          Left = 199
          Top = 240
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 3
        end
        object edIspasswordcorrect: TEdit
          Left = 199
          Top = 280
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 4
        end
        object edPageCount: TEdit
          Left = 199
          Top = 120
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 5
        end
        object edMIMEType: TEdit
          Left = 199
          Top = 200
          Width = 334
          Height = 21
          ReadOnly = True
          TabOrder = 6
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'PDFFiles(*.pdf)|*.pdf'
    Left = 408
    Top = 11
  end
  object SaveDialog1: TSaveDialog
    Left = 440
  end
  object gtStarDocsSDK1: TgtStarDocsSDK
    ConnectionInfo.ServerTimeout = -1
    ConnectionInfo.DocOperationTimeout = -1
    ConnectionInfo.PollInterval = 1000
    Preferences.DocPasswordSettings.ForceFullPermission = False
    Left = 492
    Top = 3
  end
  object ActionList1: TActionList
    Left = 292
    Top = 443
    object BrowseForFolder1: TBrowseForFolder
      Category = 'File'
      Caption = 'BrowseForFolder1'
      DialogCaption = 'BrowseForFolder1'
      BrowseOptions = []
      BrowseOptionsEx = []
      OnAccept = BrowseForFolder1Accept
    end
    object BrowseForFolder2: TBrowseForFolder
      Category = 'File'
      Caption = 'BrowseForFolder2'
      DialogCaption = 'BrowseForFolder2'
      BrowseOptions = []
      BrowseOptionsEx = []
      OnAccept = BrowseForFolder2Accept
    end
    object BrowseForFolder3: TBrowseForFolder
      Category = 'File'
      Caption = 'BrowseForFolder3'
      DialogCaption = 'BrowseForFolder3'
      BrowseOptions = []
      BrowseOptionsEx = []
      OnAccept = BrowseForFolder3Accept
    end
    object BrowseForFolder4: TBrowseForFolder
      Category = 'File'
      Caption = 'BrowseForFolder4'
      DialogCaption = 'BrowseForFolder4'
      BrowseOptions = []
      BrowseOptionsEx = []
      OnAccept = BrowseForFolder4Accept
    end
    object BrowseForFolder5: TBrowseForFolder
      Category = 'File'
      Caption = 'BrowseForFolder5'
      DialogCaption = 'BrowseForFolder5'
      BrowseOptions = []
      BrowseOptionsEx = []
      OnAccept = BrowseForFolder5Accept
    end
  end
end
