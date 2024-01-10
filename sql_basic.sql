-- 問1
-- 国名を全て抽出してください。
SELECT
    *
from
    countries
;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    continent = 'Europe'
;

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    continent <> 'Europe'
;

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    100000 <= population
;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    life_expectancy >= 56
AND life_expectancy < 77
;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT
    district
from
    cities
WHERE
    country_code in('NLB', 'ALB', 'DZA')
;

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    indep_year is null
;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT
    *
from
    countries
WHERE
    indep_year is not null
;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT
    *
from
    countries
WHERE
    name like '%ia'
;

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT
    *
from
    countries
WHERE
    name like '%st%'
;

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT
    *
from
    countries
WHERE
    name like 'an%'
;

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT
    *
from
    countries
WHERE
    indep_year <= 1900
or  population >= 100000
;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT
    *
from
    countries
WHERE
    code in('DZA', 'ALB')
and indep_year <= 1990
;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT DISTINCT
    region
from
    countries
;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT
    CONCAT(name, 'の人口は', population, '人です。')
from
    countries
;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT
    name,
    life_expectancy
from
    countries
WHERE
    life_expectancy is not null
order by
    life_expectancy
;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT
    name,
    life_expectancy
from
    countries
WHERE
    life_expectancy is not null
order by
    life_expectancy desc
;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT
    name,
    life_expectancy,
    indep_year
from
    countries
order by
    life_expectancy desc,
    indep_year desc
;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT
    SUBSTRING(
        code
        from
            1 for 1
    ),
    name
from
    countries
;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT
    name,
    length(name)
from
    countries
order by
    length(name) desc
;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT
    AVG(life_expectancy),
    AVG(population)
from
    countries
group by
    region
;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT
    MAX(life_expectancy),
    MAX(population)
from
    countries
group by
    region
;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT
    min(surface_area)
from
    countries
WHERE
    continent = 'Asia'
;

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT
    sum(surface_area)
from
    countries
WHERE
    continent = 'Asia'
;

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
SELECT
    name,
    language
from
    countries
    inner join
        countrylanguages
    on  countries.code = countrylanguages.country_code
;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT
    countries.name,
    language,
    cities.name
from
    countries
    inner join
        countrylanguages
    on  countries.code = countrylanguages.country_code
    inner join
        cities
    on  countries.code = cities.country_code
;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT
    celebrities.name,
    country_code
from
    celebrities
    left join
        countries
    on  celebrities.country_code = countries.code
;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT
    celebrities.name,
    country_code
from
    celebrities
    left join
        countries
    on  celebrities.country_code = countries.code
;

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。
SELECT
    celebrities.name,
    (
        SELECT
            name
        from
            countries
        where
            celebrities.country_code = countries.code
    )
from
    celebrities
;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT
    countries.name
from
    countries
where
    (
        SELECT
            MAX(celebrities.age)
        from
            celebrities
        where
            celebrities.country_code = countries.code
    ) >= 50
and (
        SELECT
            min(celebrities.age)
        from
            celebrities
        where
            celebrities.country_code = countries.code
    ) <= 30
;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT
    count(id)
from
    celebrities
where
    birth BETWEEN '1991-1-1' AND '1991-12-31'
union all
SELECT
    count(id)
from
    celebrities
where
    birth BETWEEN '1981-1-1' AND '1981-12-31'
;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
select
    countries.name,
    avg(celebrities.age)
from
    countries
    inner join
        celebrities
    ON  countries.code = celebrities.country_code
group by
    countries.name
order by
    avg(celebrities.age) asc
;
