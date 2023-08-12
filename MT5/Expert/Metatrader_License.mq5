//+------------------------------------------------------------------+
//|                                           Metatrader_License.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"


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
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
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
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
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
  }
//+------------------------------------------------------------------+
