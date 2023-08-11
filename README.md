# Instructions for adding licensing code to an Expert Advisor and Indicator in both MetaTrader 4 (MT4) and MetaTrader 5 (MT5)

## Description

The above steps describe how to implement licensing code in an Expert Advisor/Indicator  for both MetaTrader 4 (MT4) and MetaTrader 5 (MT5). First, a unique Product Code is generated as an identifier for the license. The Expert Advisor's code is then modified by replacing an string with the generated Product Code. The Expert Advisor is compiled, and the resulting .ex4 (or .ex5) file is provided to the client. The client is instructed to input the provided Serial Key when attaching the Expert Advisor to a chart. The Expert Advisor internally validates the license by comparing the Product Code and Serial Key using the MetaTraderValidation library. If validation is successful, the Expert Advisor functions normally; otherwise, it takes appropriate action based on the implementation. This process helps protect the Expert Advisor and ensures that only authorized clients can use it.

## Table of Content
* For MetaTrader 4 (MT4) Expert Advisor
* For MetaTrader 4 (MT4) Indicator
* For MetaTrader 5 (MT4) Expert Advisor
* For MetaTrader 5 (MT4) Indicator


# For MetaTrader 4 (MT4) Expert Advisor:

## Step 1: Copy the MetatraderValidation.ex4 file

Open your download folder and copy the MetatraderValidation.ex4 file.

![Alt Text](Screenshot.png)

## Step 2: Open MT4 Application

Open the MetaTrader 4 (MT4) application.

![Alt Text](Screenshot(1).png)


## Step 3: Open Data Folder

Go to "File" in the top menu and click "Open Data Folder."

![Alt Text](Screenshot(2).png)

## Step 4: Navigate to MQL4 Folder

In the Data Folder, click on the "MQL4" folder.

![Alt Text](Screenshot(3).png)


## Step 5: Open Libraries Folder

Within the MQL4 folder, locate and open the "Libraries" folder.

![Alt Text](Screenshot(4).png)

## Step 6: Paste MetatraderValidation.ex4

Paste the MetatraderValidation.ex4 file you copied earlier into the "Libraries" folder.

![Alt Text](Screenshot(5).png)

## Step 7: Navigate to Experts Folder

Go back to the "MQL4" folder and click on the "Experts" folder.

![Alt Text](Screenshot(6).png)


## Step 8: Open the Expert Advisor (EA)

Locate and open the Expert Advisor (EA) you want to license using the MetaEditor.

![Alt Text](Screenshot(24).png)


## Step 9: Add License Code (Above OnInit)

Place the following code above the OnInit() function of your Expert Advisor:

```echo
#import "MetatraderValidation.ex4"
bool Validate(string Serialkey,string productCode);
void updateConnectionStatus(string);
void updateHardwareId(string);
void updateConnectionStatusConnected(string);
void updateConnectionStatusDisconnected(string);

#import
bool auth = false;

input string strMA1="---------------------------------------- License Input ----------------------------------------";//<<<<<<<< License Input >>>>>>>>

input string serialkey = ""; //Serial Keys
string ProductCode="MACD Demo EA";//Product Code
```

![Alt Text](Screenshot(7).png)

## Step 10: Add License Code (OnInit)

Place the following code inside the OnInit() function of your Expert Advisor:

```echo
if(IsDllsAllowed()==false) 
    { 
     Alert("DLL call is not allowed. Experts cannot run.");
     ExpertRemove();
    } 
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateHardwareId(serialkey);
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         updateConnectionStatusConnected(serialkey);

         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         ExpertRemove();
        }
     }
```
![Alt Text](Screenshot(8).png)


## Step 11: Add License Code (OnDeinit)

Place the following code inside the OnDeinit() function of your Expert Advisor:

```echo
 if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }
```

![Alt Text](Screenshot(9).png)

## Step 12: Add License Code (OnTick)

Place the following code inside the OnTick() function of your Expert Advisor:

```echo
 if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         //ExpertRemove();
         return ;
        }
     }
```

![Alt Text](Screenshot(23).png)


## Step 13: Replace the Product Code

Replace the string "MACD Demo EA" with the your generated Product Code, the Expert Advisor will use this Product Code to validate the license key provided by the client using the MetaTraderValidation library.

![Alt Text](Screenshot(12).png)


![Alt Text](Screenshot(13).png)


## Step 14: Compile and Provide to Client

Compile the Expert Advisor and provide the resulting .ex4 file to your client.

## Step 15: Instruct the Client

Instruct your client to enter the Serial Key in the "serialkey" input field of the Expert Advisor when place the Expert Advisor on the chart.

![Alt Text](Screenshot(10).png)

## Step 16: Validation

The Expert Advisor will validate the Serial Key with the MetaTraderValidation library and allow the client to use the Expert Advisor if the validation is successful.

![Alt Text](Screenshot(11).png)

# For MetaTrader 4 (MT4) Indicator:

## Step 1: Copy the MetatraderValidation.ex4 file

Open your download folder and copy the MetatraderValidation.ex4 file.

![Alt Text](Screenshot.png)

## Step 2: Open MT4 Application

Open the MetaTrader 4 (MT4) application.

![Alt Text](Screenshot(1).png)


## Step 3: Open Data Folder

Go to "File" in the top menu and click "Open Data Folder."

![Alt Text](Screenshot(2).png)

## Step 4: Navigate to MQL4 Folder

In the Data Folder, click on the "MQL4" folder.

![Alt Text](Screenshot(3).png)


## Step 5: Open Libraries Folder

Within the MQL4 folder, locate and open the "Libraries" folder.

![Alt Text](Screenshot(4).png)

## Step 6: Paste MetatraderValidation.ex4

Paste the MetatraderValidation.ex4 file you copied earlier into the "Libraries" folder.

![Alt Text](Screenshot(5).png)

## Step 7: Navigate to Experts Folder

Go back to the "MQL4" folder and click on the "Indicators" folder.

![Alt Text](Screenshot(25).png)


## Step 8: Open the Indicators

Locate and open the Indicator you want to license using the MetaEditor.

![Alt Text](Screenshot(26).png)


## Step 9: Add License Code (Above OnInit)

Place the following code above the OnInit() function of your Indicator:

```echo
#import "MetatraderValidation.ex4"
bool Validate(string Serialkey,string productCode);
void updateConnectionStatus(string);
void updateHardwareId(string);
void updateConnectionStatusConnected(string);
void updateConnectionStatusDisconnected(string);

#import
bool auth = false;

input string strMA1="---------------------------------------- License Input ----------------------------------------";//<<<<<<<< License Input >>>>>>>>

input string serialkey = ""; //Serial Keys
string ProductCode="MACD Demo EA";//Product Code
```

![Alt Text](Screenshot(27).png)

## Step 10: Add License Code (OnInit)

Place the following code inside the OnInit() function of your Indicator:

```echo
if(IsDllsAllowed()==false) 
    { 
     Alert("DLL call is not allowed. Experts cannot run.");
     ExpertRemove();
    } 
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateHardwareId(serialkey);
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         updateConnectionStatusConnected(serialkey);

         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         ExpertRemove();
        }
     }
```
![Alt Text](Screenshot(28).png)


## Step 11: Add License Code (OnDeinit)

Add the following code at the end  of your Indicator:

```echo
void OnDeinit(const int reason)
  {
if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }
  }
```

![Alt Text](Screenshot(30).png)

## Step 12: Add License Code (OnCalculate)

Place the following code inside the OnCalculate() function of your Indicator:

```echo
  if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
        // ExpertRemove();
         return(rates_total);
        }
     }
```

![Alt Text](Screenshot(60).png)


## Step 13: Replace the Product Code

Replace the string "MACD Demo EA" with the your generated Product Code, the Indicator will use this Product Code to validate the license key provided by the client using the MetaTraderValidation library.

![Alt Text](Screenshot(12).png)


![Alt Text](Screenshot(13).png)


## Step 14: Compile and Provide to Client

Compile the Indicator and provide the resulting .ex4 file to your client.

## Step 15: Instruct the Client

Instruct your client to enter the Serial Key in the "serialkey" input field of the Indicator when place the Indicator on the chart.

![Alt Text](Screenshot(31).png)

## Step 16: Validation

The Indicator will validate the Serial Key with the MetaTraderValidation library and allow the client to use the Indicator if the validation is successful.

![Alt Text](Screenshot(32).png)


# For MetaTrader 5  (MT5) Expert Advisor:

## Step 1: Copy the MetatraderValidation.ex5 file

Open your download folder and copy the MetatraderValidation.ex5 file.

![Alt Text](Screenshot(34).png)

## Step 2: Open MT5 Application

Open the MetaTrader 5 (MT5) application.

![Alt Text](Screenshot(35).png)


## Step 3: Open Data Folder

Go to "File" in the top menu and click "Open Data Folder."

![Alt Text](Screenshot(49).png)

## Step 4: Navigate to MQL5 Folder

In the Data Folder, click on the "MQL5" folder.

![Alt Text](Screenshot(36).png)


## Step 5: Open Libraries Folder

Within the MQL5 folder, locate and open the "Libraries" folder.

![Alt Text](Screenshot(37).png)

## Step 6: Paste MetatraderValidation.ex5

Paste the MetatraderValidation.ex5 file you copied earlier into the "Libraries" folder.

![Alt Text](Screenshot(38).png)

## Step 7: Navigate to Experts Folder

Go back to the "MQL5" folder and click on the "Experts" folder.

![Alt Text](Screenshot(40).png)


## Step 8: Open the Expert Advisor (EA)

Locate and open the Expert Advisor (EA) you want to license using the MetaEditor.

![Alt Text](Screenshot(41).png)


## Step 9: Add License Code (Above OnInit)

Place the following code above the OnInit() function of your Expert Advisor:

```echo
#import "MetatraderValidation.ex5"
bool Validate(string,string);
void updateConnectionStatus(string);
void updateHardwareId(string);
void updateConnectionStatusConnected(string);
void updateConnectionStatusDisconnected(string);
#import
bool auth = false;   

input string strMA1="---------------------------------------- License Input ----------------------------------------";//<<<<<<<< License Input >>>>>>>>

input string serialkey = ""; //Serial Keys
string ProductCode = "";//Product Code
```

![Alt Text](Screenshot(42).png)

## Step 10: Add License Code (OnInit)

Place the following code inside the OnInit() function of your Expert Advisor:

```echo
if(!TERMINAL_DLLS_ALLOWED)
     {
      Alert("Please Allow DLL Imports!");
      ExpertRemove();
     }
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateHardwareId(serialkey);
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         updateConnectionStatusConnected(serialkey);

         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         ExpertRemove();
        }
     }
```
![Alt Text](Screenshot(43).png)


## Step 11: Add License Code (OnDeinit)

Place the following code inside the OnDeinit() function of your Expert Advisor:

```echo
  if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }
```

![Alt Text](Screenshot(44).png)

## Step 12: Add License Code (OnTick)

Place the following code inside the OnTick() function of your Expert Advisor:

```echo
 if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         //ExpertRemove();
         return ;
        }
     }
```

![Alt Text](Screenshot(45).png)


## Step 13: Replace the Product Code

Replace the string "" with the your generated Product Code, the Expert Advisor will use this Product Code to validate the license key provided by the client using the MetaTraderValidation library.


![Alt Text](Screenshot(48).png)

![Alt Text](Screenshot(13).png)


## Step 14: Compile and Provide to Client

Compile the Expert Advisor and provide the resulting .ex5 file to your client.

## Step 15: Instruct the Client

Instruct your client to enter the Serial Key in the "serialkey" input field of the Expert Advisor when place the Expert Advisor on the chart.

![Alt Text](Screenshot(46).png)

## Step 16: Validation

The Expert Advisor will validate the Serial Key with the MetaTraderValidation library and allow the client to use the Expert Advisor if the validation is successful.

![Alt Text](Screenshot(47).png)

# For MetaTrader 5 (MT5) Indicator:

## Step 1: Copy the MetatraderValidation.ex5 file

Open your download folder and copy the MetatraderValidation.ex5 file.

![Alt Text](Screenshot(34).png)

## Step 2: Open MT5 Application

Open the MetaTrader 5 (MT5) application.

![Alt Text](Screenshot(35).png)


## Step 3: Open Data Folder

Go to "File" in the top menu and click "Open Data Folder."

![Alt Text](Screenshot(49).png)

## Step 4: Navigate to MQL5 Folder

In the Data Folder, click on the "MQL5" folder.

![Alt Text](Screenshot(36).png)


## Step 5: Open Libraries Folder

Within the MQL5 folder, locate and open the "Libraries" folder.

![Alt Text](Screenshot(37).png)

## Step 6: Paste MetatraderValidation.ex5

Paste the MetatraderValidation.ex5 file you copied earlier into the "Libraries" folder.

![Alt Text](Screenshot(38).png)

## Step 7: Navigate to Experts Folder

Go back to the "MQL5" folder and click on the "Indicators" folder.

![Alt Text](Screenshot(50).png)


## Step 8: Open the Indicators

Locate and open the Indicator you want to license using the MetaEditor.

![Alt Text](Screenshot(51).png)


## Step 9: Add License Code (Above OnInit)

Place the following code above the OnInit() function of your Indicator:

```echo
#import "MetatraderValidation.ex5"
bool Validate(string,string);
void updateConnectionStatus(string);
void updateHardwareId(string);
void updateConnectionStatusConnected(string);
void updateConnectionStatusDisconnected(string);
#import
bool auth = false;   

input string strMA1="---------------------------------------- License Input ----------------------------------------";//<<<<<<<< License Input >>>>>>>>

input string serialkey = ""; //Serial Keys
string ProductCode = "";//Product Code
```

![Alt Text](Screenshot(52).png)

## Step 10: Add License Code (OnInit)

Place the following code inside the OnInit() function of your Indicator:

```echo
if(!TERMINAL_DLLS_ALLOWED)
     {
      Alert("Please Allow DLL Imports!");
      ExpertRemove();
     }
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateHardwareId(serialkey);
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         updateConnectionStatusConnected(serialkey);

         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         ExpertRemove();
        }
     }
```
![Alt Text](Screenshot(53).png)


## Step 11: Add License Code (OnDeinit)

Add the following code at the end  of your Indicator:

```echo
void OnDeinit(const int reason)
  {
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }

  }
```

![Alt Text](Screenshot(54).png)

## Step 12: Add License Code (OnCalculate)

Place the following code inside the OnCalculate() function of your Indicator:

```echo
  if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      auth = Validate(serialkey,ProductCode);
      if(auth == true)
        {
         Comment("Active");
         // last_check_expiry = iTime(Symbol(),check_expiry_timeframe,0);
         // EventSetTimer(60);
        }
      if(auth == false)
        {
         Comment("Inactive. Contact Provider to Activate");
         //ExpertRemove();
         return rates_total;
        }
     }
```

![Alt Text](Screenshot(55).png)


## Step 13: Replace the Product Code

Replace the string "" with the your generated Product Code, the Indicator will use this Product Code to validate the license key provided by the client using the MetaTraderValidation library.

![Alt Text](Screenshot(56).png)


![Alt Text](Screenshot(13).png)


## Step 14: Compile and Provide to Client

Compile the Indicator and provide the resulting .ex5 file to your client.

## Step 15: Instruct the Client

Instruct your client to enter the Serial Key in the "serialkey" input field of the Indicator when place the Indicator on the chart.

![Alt Text](Screenshot(57).png)

## Step 16: Validation

The Indicator will validate the Serial Key with the MetaTraderValidation library and allow the client to use the Indicator if the validation is successful.

![Alt Text](Screenshot(58).png)


