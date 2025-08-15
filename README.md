Databázový systém pro základní a střední školy (Oracle SQL)
Mělo by se jednat o DB systém, který by mohl sloužit jako DB pro např. Bakaláři (https://www.bakalari.cz/), tj. systém pro elektronickou žákovskou, ale umožňuje také zobrazení rozvrhu a další funkce.
Systém by měl obsahovat tabulky jako: žák, učitel, rodič, předmět, rozvrh, žákovská, atd.
DB systém bude mít  hodně funkcí, zatím uvedu pár - např.: prozkoumat jak se liší průměr známek  z matematiky napříč ročníky/učiteli/třídami.

Pokud by DB systém nebyl dostatečně velký, tak by do něj šlo zakomponovat:
- rozšíření pro VŠ - zkoušky, odstranění rodiče, atd.
- pro ZŠ a SŠ třeba ještě nějaké tabulky a funkce pro školní jídelnu

---

### Naming

- `tables/`: tbl_<table_name>.sql
- `packages/`: pkg_<package_name>.sql
- `views/`: vw_<view_name>.sql
- `sequences/`: seq_<sequence_name>.sql
- `triggers/`: trg_<trigger_name>.sql
- `indexes/`: idx_<index_name>.sql

---

### TO-DO's

- Index pro každý foreign key. 