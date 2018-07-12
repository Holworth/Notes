#include<ctime>
#include<iostream>

using namespace std;

enum weekdays
{
    mon,
    tue,
    wen,
    thu,
    fri,
    sat,
    sun
};

enum time_type
{
    daily,
    weekly,
    monthly
};

class Time
{
  public:
    Time()
    {
        //Do nothing
    }
    Time(int hour, int min)
    {
        hour_ = hour;
        min_ = min;
        type_ = daily;
    }
    Time(weekdays day, int hour, int min)
    {
        day_ = day;
        hour_ = hour;
        min_ = min;
        type_ = weekly;
    }
    Time(const Time &src)
    {
        type_ = src.type_;
        day_ = src.day_;
        hour_ = src.hour_;
        min_ = src.min_;
    }

    Time operator=(const Time &src)
    {
        type_ = src.type_;
        day_ = src.day_;
        hour_ = src.hour_;
        min_ = src.min_;
        return *this;
    }

    int operator-(Time &b) //return the gap between two time points
    {
        int min_a;
        int min_b;
        if (type_ == daily)
        {
            if (b.type_ == daily) //daily-daily
            {
                min_a = hour_ * 60 + min_;
                min_b = b.hour_ * 60 + min_;
                if (min_a > min_b)
                    return min_a - min_b;
                else
                    return min_a + 60 * 24 - min_b;
            }
            else
            {
                //daily-weekly
                //the same as above
                min_a = hour_ * 60 + min_;
                min_b = b.hour_ * 60 + min_;
                if (min_a > min_b)
                    return min_a - min_b;
                else
                    return min_a + 60 * 24 - min_b;
            }
        }
        else
        {
            if (b.type_ == daily)
            {
                //weekly - daily
                //the same as above
                min_a = hour_ * 60 + min_;
                min_b = b.hour_ * 60 + min_;
                if (min_a > min_b)
                    return min_a - min_b;
                else
                    return min_a + 60 * 24 - min_b;
            }
            else //weekly-weekly
            {
                min_a = day_ * 60 * 24 + hour_ * 60 + min_;
                min_b = b.day_ * 60 * 24 + b.hour_ * 60 + min_;
                if (min_a > min_b)
                    return min_a - min_b;
                else
                    return min_a + 7 * 60 * 24 - min_b;
            }
        }
    }

    Time operator+(Time &b) //used for calc the time of arrival, will change time type from daily to weekly/monthly
    {
        // throw("Undefined.");
        // "this" should be a weekly/monthly format time instance. 
        
    }

    Time operator+(int b) //used for calc the time of arrival, will change time type from daily to weekly/monthly
    {
        // throw("Undefined.");
        // "this" should be a weekly/monthly format time instance.
        // b is duration: min
        int min = ((type_==daily)?0:(day_ * 60 * 24)) + hour_ * 60 + min_;
        min += b;
        Time result;
        result.type_ = weekly;
        result.min_ = min % 60;
        result.hour_ = min/60%24;
        result.day_ = min / (60 * 24);
        return result;
    }

    void print()
    {
        if (type_ == weekly)
        {
            switch (day_)
            {
            case mon:
                cout << "Mon ";
                break;
            case tue:
                cout << "Tue ";
                break;
            case wen:
                cout << "Wen ";
                break;
            case thu:
                cout << "Thu ";
                break;
            case fri:
                cout << "Fri ";
                break;
            case sat:
                cout << "Sat ";
                break;
            case sun:
                cout << "Sun ";
                break;
            }
        }
        if (type_ == monthly)
            cout << day_ << " this month. ";
        // if(type_==daily)
        {
            cout << hour_ << ":" << min_;
            return;
        }
    }

    friend ostream &operator<<(ostream &out, Time &time);
    friend istream &operator>>(istream &in, Time &time);
    int interactive_input();
    bool operator<(Time& b)
    {
        if(type_==daily||b.type_==daily)
            throw("Type error.");
        return (b.day_ * 60 * 24 + b.hour_ * 24 + b.min_ - day_ * 60 * 24 - hour_ * 24 - min_) > 0;
    }

    bool operator>(Time& b)
    {
        if(type_==daily||b.type_==daily)
            throw("Type error.");
        return (b.day_ * 60 * 24 + b.hour_ * 24 + b.min_ - day_ * 60 * 24 - hour_ * 24 - min_) < 0;
    }

    // time_type type_;
    int type_;

    int day_;
    int hour_;
    int min_;
};

Time time_now()
{
    time_t t;
    struct tm *lt;
    time(&t);           //获取Unix时间戳。
    lt = localtime(&t); //转为时间结构。
    // printf("%d/%d/%d %d:%d:%d\n", lt->tm_year + 1900, lt->tm_mon, lt->tm_mday, lt->tm_hour, lt->tm_min, lt->tm_sec); //输出结果
    Time r(lt->tm_hour, lt->tm_min);
    return r;
}