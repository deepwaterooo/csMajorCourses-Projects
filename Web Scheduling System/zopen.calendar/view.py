#-*-encoding=utf-8-*-
@script_attr(permission='zope.Public',use_template='blank')
def index():
    """index

None"""

    from datetime import date, timedelta
    
    def getSumIndexInfo(int_list, sum):
        offset = sum
        index = 0
        for i in int_list:
            offset -= i
            if offset < 0:
                return index, offset + i 
    
            index += 1
    
    MINYEAR,MAXYEAR = 1900, 2050
    daysInSolarMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    lunarMonthDays = [29,30] # a short (long) lunar month has 29 (30) days */
    
    shengXiaoEn = ["Mouse", "Ox", "Tiger", "Rabbit", "Dragon", "Snake",
    			   "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]
    shengXiaoGB = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡",
    			   "狗", "猪"]
    zhiGB = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉",
    			   "戌", "亥"]
    ganGB = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    
    monthEn = ['January', 'February', 'March', 'April', 'May', 'June',
    			   'July', 'August', 'September', 'October', 'November',
    			   'December']
    weekdayEn = ["Monday", "Tuesday", "Wednesday", "Thursday",
    			   "Friday", "Saturday", "Sunday"]
    weekdayGB = ["一", "二", "三", "四", "五", "六", "日"]
    lunarHolidays = {(1, 1):'春节', (5, 5):'端午', (8, 15):'中秋', (9,9):'重阳',(1, 15):'元宵'}
    solarTerms = {(2, 4):'立春', (2, 18):'雨水', (3, 5):'惊蛰', (3, 20):'春分',
                  (4,4):'清明',(4,20):'谷雨', (5,5):'立夏', (5,21):'小满',
                  (6,5):'芒种', (6,21):'夏至', (7,16):'小暑', (7,22):'大暑',
                  (8,7):'立秋', (8,22):'处暑', (9,7):'白露', (9,23):'秋分',
                  (10,8):'寒露', (10,23):'霜降', (11,7):'立冬', (11,22):'小雪',
                  (12,7):'大雪',(12,22):'冬至',(1,5):'小寒', (1,20):'大寒' }
    yearCode = [
                                            0x04bd8,        # 1900
        0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950,        # 1905
        0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0,        # 1910
        0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540,        # 1915
        0x0d6a0, 0x0ada2, 0x095b0, 0x14977, 0x04970,        # 1920
        0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54,        # 1925
        0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566,        # 1930
        0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60,        # 1935
        0x186e3, 0x092e0, 0x1c8d7, 0x0c950, 0x0d4a0,        # 1940
        0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0,        # 1945
        0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0,        # 1950
        0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573,        # 1955
        0x052d0, 0x0a9a8, 0x0e950, 0x06aa0, 0x0aea6,        # 1960
        0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260,        # 1965
        0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0,        # 1970
        0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250,        # 1975
        0x0d558, 0x0b540, 0x0b5a0, 0x195a6, 0x095b0,        # 1980
        0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50,        # 1985
        0x06d40, 0x0af46, 0x0ab60, 0x09570, 0x04af5,        # 1990
        0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58,        # 1995
        0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960,        # 2000
        0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0,        # 2005
        0x0abb7, 0x025d0, 0x092d0, 0x0cab5, 0x0a950,        # 2010
        0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0,        # 2015
        0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954,        # 2020
        0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6,        # 2025
        0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0,        # 2040
        0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0,        # 2045
        0x0aa50, 0x1b255, 0x06d20, 0x0ada0                  # 2049
        ]
    
    lunar_years = range(MINYEAR, MINYEAR + len(yearCode))
    solar1st = (MINYEAR, 1, 30)   # January 31, 1900 
    lunar1st = (MINYEAR, 1, 1) # First day, First month, 1900, 庚/子年
    lunar1st_gan = 6
    lunar1st_zhi = 0
    chinese_month_name = ["春节", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", '冬月', '腊月']
    
    def chineseDay(day):
        return ['初', "十", '二', '卅'] [day/10] \
               + ['○', "一", "二", "三", "四", "五", "六", "七", "八", "九"][day%10]
               
    def getLunarYearInfo(year):
            """
            >>> cal = LunarCalendar()
            >>> cal.getLunarYearInfo( 2003 )
            ([30, 30, 29, 30, 30, 29, 30, 29, 29, 30, 29, 30], 0)
            """
            iYear = year - lunar_years[0]
            code = yearCode[iYear]
            leapMonth = code&0xf #leapMonth==0 means no lunar leap month
            monthDays = [0] * 12
    
            code >>= 4
            for iMonth in range(12):
                monthDays[11-iMonth] = lunarMonthDays [code&0x1]
                code >>= 1
    
            if leapMonth>0:
                monthDays.insert (leapMonth-1, lunarMonthDays [code & 0x1])
            return monthDays, leapMonth
    
    # 1.有关年分信息查询
    def getLeapMonthOfThisYear( year):
            """ 输入年份,返回本年度阴历的闰月
    
            如果没有,就返回空,否则返回今年的闰月"""
            monthDays, leapMonth = getLunarYearInfo()
            return leapMonth
    
    
    def getAnimalSign(year):
        """输入年份,返回本年度属相
    
            输出:animalSign
    
            >>> cal = LunarCalendar()
            >>> print cal.getAnimalSign(2008)
            鼠
        """
        diff_years = year - lunar_years[0]
        zhi_index = ( diff_years + lunar1st_zhi ) % 12
        return shengXiaoGB[zhi_index]
    
    def getGanZhi(year):
        """输入年份,返回本年年号(天干地支)
    
        输出:heavenly, Earthly
        >>> cal = LunarCalendar()
        >>> gan,zhi = cal.getGanZhi(2008)
        >>> print gan + zhi
        戊子
        """
        diff_years = year - lunar_years[0]
        zhi_index = ( diff_years + lunar1st_zhi ) % 12
        gan_index = ( diff_years + lunar1st_gan ) % 10
        return ganGB[gan_index], zhiGB[zhi_index]
    
    
    def getLunarMonthDays(year,month, isleap=False):
    	""""输入年份月份,返回本月天数
    
    	输出:num"""
    	month_days = getLunarYearInfo(year)[0]
    	index = month - 1 + (isleap and 1 or 0)
    	return month_days[index]
    	
    
    def getLunarDate(year,month,day):
        """输入阳历年月日,返回本日阴历
    
        输出:(year,month,day, isleap)
    
         >>> cal = LunarCalendar()
         >>> cal.getLunarDate(1975,1,3)
            (1974, 11, 21, 0)
         >>> cal.getLunarDate(2008,2,7)
            (2008, 1, 1, 0)
         >>> cal.getLunarDate(1982,11,30)
            (1982, 10, 16, 0)
        """
        # 1. 到阳历起始时间的间隔天数
        diff_days = date(year, month, day) - date(*solar1st)
        diff_days = diff_days.days
    
        # 2. year: 到阴历起始时间的间隔年数
        # 3. 是阴历年内的第几天?
        year_index, year_offset = getSumIndexInfo(lunar_year_days, diff_days)
        year = lunar_years[0] + year_index 
    
        # 4. month, isleap: 是阴历年内的第几月？是否闰月
        monthDays, leapMonth = getLunarYearInfo(year)
        month_index, month_offset = getSumIndexInfo(monthDays, year_offset)
    
        isleap = 0
        if leapMonth > 0: 
            if leapMonth == month_index + 1:
                isleap = 1
            if leapMonth <= month_index + 1:
                month_index -= 1
        month = month_index + 1
    
        # 5. day, 月内的第几天?
        if month_offset == 0:
            if month == 1:
                year, month = (year-1), 12
            else:
                month = month -1
            day = getLunarMonthDays(year, month)
        else:
            day = month_offset
        
        return year, month ,day , isleap
    
    def getSolarDate(year,month,day, isleap=False):
        """输入阴历年月日,返回本日阳历信息
    
    	输出:(year,month,day) 
    
            >>> cal = LunarCalendar()
            >>> cal.getSolarDate(1974,11,21)
            (1975, 1, 3)
            >>> cal.getSolarDate(1986,7,22)
            (1986, 8, 27)
            >>> cal.getSolarDate(1987,6,11)
            (1987, 7, 6)
            >>> cal.getSolarDate(1982, 10, 16)
            (1982, 11, 30)
            >>> cal.getSolarDate(2008, 1, 1)
            (2008, 2, 7)
            >>> cal.getSolarDate(2009, 1, 1)
            (2009, 1, 26)
        """
        # 1. 到起始时间的间隔天数
        diff_days = 0
        for i in range(year - lunar_years[0]):
            diff_days += lunar_year_days[i]
    
        monthDays, leapMonth = getLunarYearInfo(year)
        monthIndex = month + ( leapMonth and month > leapMonth and 1 or 0) + (isleap and 1 or 0)
    
        diff_days += sum( monthDays[:monthIndex-1] ) + day
    
        solar_date = date(*solar1st) + timedelta(diff_days)
        return solar_date.year, solar_date.month, solar_date.day
    
    # 初始化阴历各年的总天数
    lunar_year_days = [sum( getLunarYearInfo(year)[0] ) \
                                       for year in lunar_years]
    
    
    ##########################
    # real code
    ##########################
    
    year = int(request.get('year', 0))
    month = int(request.get('month', 0))
    day = int(request.get('day', 0))
    if year == 0 or month == 0 or day == 0:
        today = datetime.date.today()
        year = today.year
        month = today.month
        day = today.day
    
    lunal_year, lunal_month, lunal_day, luanl_run= getLunarDate(year, month, day)
    
    gan, zhi = getGanZhi(lunal_year)
    lunal_year_info = '%s%s年 %s ' %( gan,zhi, getAnimalSign(lunal_year),)
    
    
            
    cal = calendar.monthcalendar(year, month)
    l = datetime.datetime(year, month, 1, 0, 0, 0)  - datetime.timedelta(10)
    l_year, l_month = l.year, l.month
    n = datetime.datetime(year, month, 1, 0, 0, 0)  + datetime.timedelta(32)
    n_year, n_month = n.year, n.month
    
    cal_url = '++script++zopen.calendar.index'
    
    lunal_dayinfo = {}
    for anyday in range(1, 32):
        try:
           lunal_year, lunal_month, lunal_day, luanl_run= getLunarDate(year, month, anyday)
        except:
            continue
        info = ''
    
        if (month, anyday) in solarTerms:
            info = solarTerms[(month, anyday)]
        if (lunal_month, lunal_day) in lunarHolidays:
            info = lunarHolidays[(lunal_month, lunal_day)]
        if lunal_day == 1:
            info = chinese_month_name[lunal_month-1]
            if luanl_run:
                info = '闰' + info
        if not info:
            info = chineseDay(lunal_day)
        lunal_dayinfo[anyday] = info    
    
    return render_template(u'cal', year=year, month=month, day=day, cal = cal, lunal_year_info=lunal_year_info,
                           lunal_dayinfo = lunal_dayinfo,
    n_year = n_year, n_month = n_month, l_year = l_year, l_month=l_month, cal_url=cal_url,)
    
