#NoEnv
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetBatchLines, -1

Class FileMapping {   
    __New(Name="Global\ThToAhk", BufSize=10000) 
	{   
        static INVALID_HANDLE_VALUE := -1, PAGE_READWRITE := 0x4, FILE_MAP_ALL_ACCESS := 0xF001F
        hFile := DllCall("OpenFileMapping", "Ptr", FILE_MAP_ALL_ACCESS, "Int", 0, "Str", Name)
        if ( hFile == 0 ) 
		{       
            hFile := DllCall("CreateFileMapping", "Ptr", INVALID_HANDLE_VALUE, "Ptr", 0, "Int", PAGE_READWRITE, "Int", 0, "Int", BufSize, "Str", Name)
            if ( hFile == 0 )   
                return
        }
        MapViewOfFile := DllCall("MapViewOfFile", "Ptr", hFile, "Int", FILE_MAP_ALL_ACCESS, "Int", 0, "Int", 0, "Ptr", BufSize)
        if ( MapViewOfFile == 0 )  
            return
        this.Name := Name, this.hFile := hFile, this.MapViewOfFile := MapViewOfFile, this.BufSize := BufSize
    }
    Write(String="") 
	{   
        if (StrLen(String)*(A_Isunicode ? 2 : 1) <= this.BufSize) 
		{
            Num := StrPut(String, this.MapViewOfFile)
            return Num
        }
    }
    Read() 
	{
        return StrGet(this.MapViewOfFile)
    }
    __Delete() 
	{
        DllCall("UnmapViewOfFile", "Ptr", this.MapViewOfFile), DllCall("CloseHandle", "Ptr", this.hFile)
    }
}



Gui, myGui:New, hwndhGui AlwaysOnTop Resize MinSize

Gui, myGui:Add, Edit, w320 r8 ReadOnly vText123


Gui, myGui:Show, NoActivate, WizComboBlackHole

toggle := 0

FM := new FileMapping()

RotationTimerCurrent := 2
RotationCounter := 2

; An example class for counting the seconds...
class ConventionCounter {
    __New() {
	
	
	
	
        this.interval := 127
        ; Tick() has an implicit parameter "this" which is a reference to
        ; the object, so we need to create a function which encapsulates
        ; "this" and the method to call:
		this.LowerBound := 32000
		this.UpperBound := 32000
		this.TimeShift := 0
		
        this.timer := ObjBindMethod(this, "Tick")
    }
    Start() {
        ; Known limitation: SetTimer requires a plain variable reference.
        timer := this.timer
        SetTimer % timer, % this.interval
    }
    Stop() {
        ; To turn off the timer, we must pass the same object as before:
        timer := this.timer
        SetTimer % timer, Off
    }
    ; In this example, the timer calls this method:
    Tick() {
        OldDistance := mod((this.UpperBound - this.LowerBound + 16000),16000)
		
		ToolTip % Time
		
		if(this.LowerBound==32000)
		{
			OldDistance := 100000
		}
		if(this.UpperBound==32000)
		{
			OldDistance := 100000
		}
			
			global FM
			global RotationTimerCurrent
			global RotationCounter
			global toggle
			Value2 := % FM.Read()
	
			Time := mod(A_TickCount,16000)
			
			
		if((SubStr(Value2, 2, 1))==1)
		{
			;Lightning
			Distance := mod((Time - this.LowerBound + 32000),16000)
			if(Distance<OldDistance)
			{
				this.UpperBound := mod(Time + 32000,16000)
			}
			

			Distance := mod((this.UpperBound + 4000 - Time + 32000),16000)
			if(Distance<OldDistance)
			{
				this.LowerBound := mod(Time - 4000 + 32000,16000)
			}
		}
		
		if((SubStr(Value2, 3, 1))==1)
		{
			;Arcane
			Distance := mod((Time - this.LowerBound - 4000 + 32000),16000)
			if(Distance<OldDistance)
			{
				this.UpperBound := mod(Time - 4000 + 32000,16000)
			}
			

			Distance := mod((this.UpperBound + 8000 - Time + 32000),16000)
			if(Distance<OldDistance)
			{
				this.LowerBound := mod(Time - 8000 + 32000,16000)
			}
		}
		
		if((SubStr(Value2, 4, 1))==1)
		{
			;Cold
			Distance := mod((Time - this.LowerBound - 8000 + 32000),16000)
			if(Distance<OldDistance)
			{
				this.UpperBound := mod(Time - 8000 + 32000,16000)
			}
			

			Distance := mod((this.UpperBound + 12000 - Time + 32000),16000)
			if(Distance<OldDistance)
			{
				this.LowerBound := mod(Time - 12000 + 32000,16000)
			}
		}
		
		if((SubStr(Value2, 5, 1))==1)
		{
			;Fire
			Distance := mod((Time - this.LowerBound - 12000 + 32000),16000)
			if(Distance<OldDistance)
			{
				this.UpperBound := mod(Time - 12000 + 32000,16000)
			}
			

			Distance := mod((this.UpperBound - Time + 32000),16000)
			if(Distance<OldDistance)
			{
				this.LowerBound := mod(Time + 32000,16000)
			}
		}
		
		BoundDistance := Abs(this.UpperBound - this.LowerBound)
		
		if(BoundDistance>8000)
		{
			this.TimeShift := (this.UpperBound + this.LowerBound+16000)/2
		}
		else
		{
			this.TimeShift := (this.UpperBound + this.LowerBound)/2
		}
		
	
		Value2 := % FM.Read()
		
		v1 := % this.UpperBound
		v2 := % this.LowerBound
		v3 := % this.TimeShift
		v4 := % mod(A_TickCount-this.TimeShift,16000)
		
		v5 := % SubStr(Value2, 1, 1)
		v6 := % SubStr(Value2, 2, 1)
		v7 := % SubStr(Value2, 3, 1)
		v8 := % SubStr(Value2, 4, 1)
		v9 := % SubStr(Value2, 5, 1)
		v10 := % SubStr(Value2, 6, 1)
		
		v11 := % RotationCounter
		
		v12 := % mod(RotationTimerCurrent-this.TimeShift,16000) - 4000
		
		v13 := toggle
		
		if(RotationCounter>1) 
		{
			v11 = % v11 / RotationCounter
		}
		k := v1 "`n" v2 "`n" v3 "`n" v4 "`n" v5 " " v6 " " v7 " " v8 " " v9 " " v10 "`n" v11 "`n" v12 "`n" v13
		
		Gui, myGui: Default
		GuiControl,, Text123, % k
    }
}







counter := new ConventionCounter
counter.Start()



return

GuiClose:
ExitApp

DoStuff(x)
{
		global counter
		global FM


		DooingArcane := 0
		SavedBlackHole := 0
		Convention := mod(A_TickCount-counter.TimeShift,16000)
		
		if(Convention>1150&&Convention<1900)
		{
			DooingArcane := 1
			Send 1
			
			Value2 := % FM.Read()
			if(SubStr(Value2, 6, 1)==1)
			{
				SavedBlackHole := 1
				;got blackhole from ES so dont use it
			}
			else
			{
				MouseClick, right
			}
			
			Sleep 200
			SendInput {2 down}
			Sleep 1400
			Send 3
			Sleep 1200
			
			if(SavedBlackHole == 1)
			{
				SendInput {2 up}
			}
			
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			
		
			if(!GetKeyState("5","P")&&(x==1)) 
			{
			return
			}
			
			if(SavedBlackHole == 1)
			{
				Sleep 300
				Send 1
				MouseClick, right
				SendInput {2 down}
			}
			else
			{
				SendInput {1 down}
				Sleep 100
				SendInput {1 up}
				Sleep 200
			}
			
			Sleep 1500
			SendInput 3
			Sleep 1200
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			SendInput {1 down}
			Sleep 100
			SendInput {1 up}
			RotationCounter := 0
		}
		
		if(Convention>4000&&Convention<7000 && (DooingArcane == 0))
		{
			SendInput 3
			Sleep 1200
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			SendInput {1 down}
			Sleep 100
			SendInput {1 up}
		}
		
		else if(Convention>9300&&Convention<10300)
		{

			SendInput 3
			Sleep 1200
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			SendInput {1 down}
			Sleep 100
			SendInput {1 up}
		}
		else if(Convention>12200&&Convention<13200)
		{

			SendInput 3
			Sleep 1200
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			SendInput {1 down}
			Sleep 100
			SendInput {1 up}
		}
		else if(Convention>15100)
		{

			SendInput 3
			Sleep 1200
			SendInput {4 down}
			Sleep 400
			SendInput {4 up}
			SendInput {2 up}
		}
}



$5::
SendInput {2 down}
While GetKeyState("5","P")
	{
	
		DoStuff(1)
		Sleep 1
	}
SendInput {2 up}
Return

$6::
counter.Start()
  counter.LowerBound := 32000
  counter.UpperBound := 32000
Return

$7::
  counter.LowerBound := counter.LowerBound-1000
  if(counter.LowerBound<0)
  {
  counter.LowerBound += 16000
  }
  counter.UpperBound := counter.UpperBound+1000
  if(counter.UpperBound>16000)
  {
  counter.UpperBound -= 16000
  }
Return



$8::
	toggle:=!toggle
	SendInput {2 down}
	while (toggle==1)
	{
		DoStuff(0)
		Sleep 1
	}
	SendInput {2 up}
return

$9::MsgBox,,, % FM.Read(), 1