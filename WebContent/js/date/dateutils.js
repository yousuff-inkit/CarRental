// dateUtils.js - small, dependency-free date helpers
(function(window){
  'use strict';

  const DateUtils = {
    // parse dd.MM.yyyy or Date object -> returns Date or null
    parseDDMMYYYY: function(v){
      if(!v) return null;
      if(v instanceof Date) return new Date(v.getTime());
      // accept either "dd.MM.yyyy" or "yyyy-MM-dd" or Date-like strings.
      if(typeof v !== 'string') return null;
      // try dd.MM.yyyy
      var m = v.match(/^(\d{1,2})\.(\d{1,2})\.(\d{4})$/);
      if(m){
        return new Date(parseInt(m[3],10), parseInt(m[2],10)-1, parseInt(m[1],10));
      }
      // fallback to Date constructor (handles yyyy-mm-dd etc)
      var d = new Date(v);
      return isNaN(d.getTime()) ? null : d;
    },

    // format Date -> dd.MM.yyyy
    formatDDMMYYYY: function(date){
      if(!date) return '';
      if(!(date instanceof Date)) date = this.parseDDMMYYYY(date);
      if(!date) return '';
      const dd = ('0'+date.getDate()).slice(-2);
      const mm = ('0'+(date.getMonth()+1)).slice(-2);
      const yyyy = date.getFullYear();
      return dd + '.' + mm + '.' + yyyy;
    },

    // set time part to 00:00:00
    startOfDay: function(d){
      if(!(d instanceof Date)) d = this.parseDDMMYYYY(d);
      d.setHours(0,0,0,0);
      return d;
    },

    // compare only date portion (no time)
    compareDates: function(a,b){
      const A = this.startOfDay(new Date(a)).getTime();
      const B = this.startOfDay(new Date(b)).getTime();
      if(A === B) return 0;
      return A < B ? -1 : 1;
    },

    // returns true if date is in [start, end]
    isInPeriod: function(date, start, end){
      const d = this.startOfDay(this.parseDDMMYYYY(date));
      if(!d) return false;
      if(start){
        const s = this.startOfDay(this.parseDDMMYYYY(start));
        if(s && d < s) return false;
      }
      if(end){
        const e = this.startOfDay(this.parseDDMMYYYY(end));
        if(e && d > e) return false;
      }
      return true;
    },

    // checks based on your existing rules: not outside account period, not future, not <= monthclose
    // periodStart/end expected dd-MM-yyyy or Date or string from parent values
    isTransactionAllowed: function(txDate, periodStart, periodEnd, monthCloseDate){
      var d = this.parseDDMMYYYY(txDate);
      if(!d) return { ok:false, msg: 'Invalid Date' };
      var cur = this.startOfDay(new Date());
      d = this.startOfDay(d);

      // account period
      if(periodStart && periodEnd){
        var ps = this.startOfDay(this.parseDDMMYYYY(periodStart));
        var pe = this.startOfDay(this.parseDDMMYYYY(periodEnd));
        if(ps && pe && (d < ps || d > pe)){
          return { ok:false, msg: 'Transaction prior or after Account Period is not valid.' };
        }
      }

      // future
      if(d > cur){
        return { ok:false, msg: 'Future Date, Transaction Restricted.' };
      }

      // month close (if provided) - if txDate <= monthClose then restricted
      if(monthCloseDate){
        var mc = this.startOfDay(this.parseDDMMYYYY(monthCloseDate));
        if(mc && d <= mc){
          return { ok:false, msg: 'Closing Done, Transaction Restricted.' };
        }
      }

      return { ok:true, msg: '' };
    },

    // small helper to safely set jqxDateTimeInput to today (if you use jqx)
    setJqxDateToToday: function(selector){
      if(window.$ && $(selector).length && $(selector).jqxDateTimeInput){
        $(selector).jqxDateTimeInput('setDate', new Date());
      }
    }
  };

  // export
  window.DateUtils = DateUtils;
})(window);
