object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 562
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 320
    Top = 160
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 24
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 192
    Top = 225
    Width = 625
    Height = 272
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=juanfcopu'
      'Password=daf5ne55'
      'Database=puchades'
      'Server=DELLDEBIAN'
      'DriverID=MySQL')
    Connected = True
    LoginDialog = FDGUIxLoginDialog1
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    Left = 568
    Top = 120
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateObject = FDUpdateSQL1
    SQL.Strings = (
      'select * from clientes')
    Left = 704
    Top = 144
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Public\Documents\Embarcadero\Studio\Projects\FIRED\libm' +
      'ysql.dll'
    Left = 400
    Top = 32
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 56
    Top = 40
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO puchades.clientes'
      '(Nombre, Direccion, Ciudad, TelefonoCasa, '
      '  TelefonoMovil, mail, NumFax, CIF, CodigoPostal, '
      '  idAdministrador, CP, IBAN)'
      
        'VALUES (:NEW_Nombre, :NEW_Direccion, :NEW_Ciudad, :NEW_TelefonoC' +
        'asa, '
      
        '  :NEW_TelefonoMovil, :NEW_mail, :NEW_NumFax, :NEW_CIF, :NEW_Cod' +
        'igoPostal, '
      '  :NEW_idAdministrador, :NEW_CP, :NEW_IBAN)')
    ModifySQL.Strings = (
      'UPDATE puchades.clientes'
      
        'SET IdContactos = :NEW_IdContactos, Nombre = :NEW_Nombre, Direcc' +
        'ion = :NEW_Direccion, '
      '  Ciudad = :NEW_Ciudad, TelefonoCasa = :NEW_TelefonoCasa, '
      
        '  TelefonoMovil = :NEW_TelefonoMovil, mail = :NEW_mail, NumFax =' +
        ' :NEW_NumFax, '
      
        '  CIF = :NEW_CIF, CodigoPostal = :NEW_CodigoPostal, idAdministra' +
        'dor = :NEW_idAdministrador, '
      '  CP = :NEW_CP, IBAN = :NEW_IBAN'
      'WHERE IdContactos = :OLD_IdContactos')
    DeleteSQL.Strings = (
      'DELETE FROM puchades.clientes'
      'WHERE IdContactos = :OLD_IdContactos')
    FetchRowSQL.Strings = (
      
        'SELECT LAST_INSERT_ID() AS IdContactos, Nombre, Direccion, Ciuda' +
        'd, '
      '  TelefonoCasa, TelefonoMovil, mail, NumFax, CIF, CodigoPostal, '
      '  idAdministrador, CP, IBAN'
      'FROM puchades.clientes'
      'WHERE IdContactos = :IdContactos')
    Left = 56
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 224
    Top = 160
  end
end
