//+------------------------------------------------------------------+
//|                                          Expert_With_License.mq4 |
//|                                 Copyright 2022, MQL Dev Software |
//|                                   https://www.mqldevelopment.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MQL Dev Software"
#property link      "https://www.mqldevelopment.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

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
string ProductCode="MACD Demo";//Product Code

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
    if(IsDllsAllowed()==false) 
    { 
     Alert("DLL call is not allowed. Experts cannot run.");
     ExpertRemove();
    } 
//--- create timer
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
   if(MQLInfoInteger(MQL_OPTIMIZATION) == 0)
     {
      updateConnectionStatusDisconnected(serialkey);
     }
//--- destroy timer
//EventKillTimer();

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
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

  }
//+------------------------------------------------------------------+
