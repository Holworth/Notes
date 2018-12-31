/**
 * @file    executor.cc
 * @author  liugang(liugang@ict.ac.cn)
 * @version 0.1
 *
 * @section DESCRIPTION
 *  
 * definition of executor
 *
 */
#include "executor.h"
using namespace std;
int64_t project_tabout_id = 456;
int64_t tabout_id_hashjoin = 777;

char **hashjoin_cmpSrcB_tables = new char *[2];
char *hashjoin_format_value = new char[128]; //Question

/**
 * Part1: There are several common useful functions that everyone can use.
 */

/** read row to result table */
bool ReadRowToResult(RowTable *src, int64_t row_rank, int64_t col_num, ResultTable *dest)
{
    int current_col;
    char *buffer;
    g_memory.alloc(buffer, 128);
    for (current_col = 0; current_col < col_num; current_col++)
    {
        if (!src->selectCol(row_rank, current_col, buffer))
        {
            g_memory.free(buffer, 128);
            return false;
        }
        if (!dest->writeRC(0, current_col, buffer))
        {
            g_memory.free(buffer, 128);
            return false;
        }
    }
    g_memory.free(buffer, 128);
    return true;
}

/** transfer const char to char   */
char *constchar2char(const char *str)
{
    size_t len = strlen(str);
    char *result = new char[len + 1];
    memcpy(result, str, len + 1);
    return result;
}

/** transfer int to string format */
string int2str(int64_t x)
{
    string s = to_string(x);
    return (s);
}
/** get a number around size,powdered by 2 */
int64_t round2(int64_t size)
{
    if (size < 0)
        return -1;
    int64_t result = 1;
    while (result < size)
        result *= 2;
    return result;
}

/** get hash number */
uint32_t gethash(char *key, BasicType *type)
{
    uint32_t hash = 0;
    for (unsigned i = 0; i < strlen(key); i++)
        hash = 31 * hash + key[i];
    return hash;
}

/** 
 * Part2
 * start to build the operator tree.
 */

/** exeutor function */
int Executor::exec(SelectQuery *query, ResultTable *result)
{
    if (query != NULL)
    {
        int join_count = 0; // number of join req
        count = 0;          // number of records
        timesin = 0;        // times comming in this function

        // find join condition and compare condition
        // store filter tid
        int64_t filter_tid[4] = {-1, -1, -1, -1}; // init of filter
        int64_t having_tid[4] = {-1, -1, -1, -1}; // init of having
        int64_t joinA_tid[4] = {-1, -1, -1, -1};
        int64_t joinB_tid[4] = {-1, -1, -1, -1};
        Condition *join_cond[4]; // condtions
        // count join link number
        for (int i = 0; i < query->where.condition_num; i++)
        {
            if (query->where.condition[i].compare == LINK)
            {
                join_cond[join_count] = &query->where.condition[i];

                Column *joinA_col = (Column *)g_catalog.getObjByName(query->where.condition[i].column.name);
                int64_t joinA_cid = joinA_col->getOid();

                Column *joinB_col = (Column *)g_catalog.getObjByName(query->where.condition[i].value);
                int64_t joinB_cid = joinB_col->getOid();

                for (int j = 0; j < query->from_number; j++)
                {
                    Table *table = (Table *)g_catalog.getObjByName(query->from_table[j].name);

                    auto columns = table->getColumns();
                    for (int k = 0; k < (int)columns.size(); k++)
                    {
                        if (joinA_cid == columns[k])
                        {
                            joinA_tid[join_count] = j;
                        }
                        if (joinB_cid == columns[k])
                        {
                            joinB_tid[join_count] = j;
                        }
                    }
                }

                join_count++;
            }
        }

        // find tables that filter columns belong to
        for (int i = 0; i < query->where.condition_num; i++)
        {
            if (query->where.condition[i].compare != LINK)
            {
                Column *filter_col = (Column *)g_catalog.getObjByName(query->where.condition[i].column.name);
                int64_t filter_cid = filter_col->getOid();
                for (int j = 0; j < query->from_number; j++)
                {
                    Table *table = (Table *)g_catalog.getObjByName(query->from_table[j].name);
                    auto columns = table->getColumns();
                    for (int k = 0; k < (int)columns.size(); k++)
                    {
                        if (filter_cid == columns[k])
                        {
                            filter_tid[i] = table->getOid();
                            break;
                        }
                    }
                }
            }
        }
        // find having conditions
        // store having tid
        for (int i = 0; i < query->having.condition_num; i++)
        {
            Column *having_col = (Column *)g_catalog.getObjByName(query->having.condition[i].column.name);
            int64_t having_cid = having_col->getOid();
            for (int j = 0; j < query->from_number; j++)
            {
                Table *table = (Table *)g_catalog.getObjByName(query->from_table[j].name);
                auto columns = table->getColumns();
                for (int k = 0; k < (int)columns.size(); k++)
                {
                    if (having_cid == columns[k])
                    {
                        having_tid[i] = table->getOid();
                        break;
                    }
                }
            }
        }

        // build the operator tree
        Operator *op[4];
        for (int i = 0; i < query->from_number; i++)
        {
            RowTable *row_table = (RowTable *)g_catalog.getObjByName(query->from_table[i].name);
            op[i] = new Scan(query->from_table[i].name);
            int64_t row_tid = row_table->getOid();
            for (int j = 0; j < 4; j++)
            {
                if (filter_tid[j] == row_tid)
                {
                    op[i] = new Filter(op[i], &query->where.condition[j]);
                }
                if (having_tid[j] == row_tid)
                {
                    op[i] = new Filter(op[i], &query->having.condition[j]);
                }
            }
        }
        Operator *newop;
        printf("DEBUG 55    %d\n", join_count);
        if (join_count > 1)
        {
            Operator ***hash_op = new Operator **[4];
            for (int i = 0; i < join_count; i++)
            {
                hash_op[i] = new Operator *[2];
                hash_op[i][0] = op[joinA_tid[i]];
                hash_op[i][1] = op[joinB_tid[i]];
                printf("DEBUG 56 %d %d %d \n", i, joinA_tid[i], joinB_tid[i]);
                newop = new HashJoin(2, hash_op[i], 1, join_cond[i]);

                op[joinA_tid[i]] = newop;
                op[joinB_tid[i]] = newop;
            }
            //  return false;
        }
        else if (join_count == 1)
        {
            newop = new HashJoin(2, op, 1, join_cond[0]);
        }
        else
            newop = op[0];

        if (query->select_number)
            newop = new Project(newop, query->select_number, query->select_column);
        if (query->groupby_number)
            newop = new GroupBy(newop, query->select_number, query->select_column);
        if (query->orderby_number)
            newop = new OrderBy(newop, query->orderby_number, query->orderby);
        //---------------------init the operator tree ---------------------
        top_op = newop;
        top_op->init();
    }
    // build result table to store result
    int col_num = (int)top_op->getTableOut()->getColumns().size();
    timesin++;
    auto row_pattern = top_op->getTableOut()->getRPattern();
    result_type = new BasicType *[col_num];
    for (int i = 0; i < col_num; i++)
        result_type[i] = row_pattern.getColumnType(i);

    //clear result table
    if (timesin > 1)
        result->shut();

    result->init(result_type, col_num, 2048);
    ResultTable final_temp_result;
    result->row_number = 0;
    final_temp_result.init(result_type, col_num, 2048);

    // write result table
    while (result->row_number < 1024 / result->row_length && top_op->getNext(&final_temp_result))
    {
        for (int j = 0; j < col_num; j++)
        {
            char *buf = final_temp_result.getRC(0, j);
            result->writeRC(result->row_number, j, buf);
        }
        result->row_number++;
    }
    count += result->row_number;

    // 	ENDS return and close
    if (result->row_number == 0)
    {
        top_op->close();
        printf("record count %ld\n", count);
        return false;
    }
    return true;
}

// note: you should guarantee that col_types is useable as long as this ResultTable in use, maybe you can new from operate memory, the best method is to use g_memory.
int ResultTable::init(BasicType *col_types[], int col_num, int64_t capicity)
{
    column_type = col_types;
    column_number = col_num;
    row_length = 0;
    buffer_size = g_memory.alloc(buffer, capicity);
    if (buffer_size != capicity)
    {
        printf("[ResultTable][ERROR][init]: buffer allocate error!\n");
        return -1;
    }
    int allocate_size = 1;
    int require_size = sizeof(int) * column_number;
    while (allocate_size < require_size)
        allocate_size = allocate_size << 1;
    if (allocate_size < 8)
        allocate_size *= 2;
    char *p = NULL;
    offset_size = g_memory.alloc(p, allocate_size);
    if (offset_size != allocate_size)
    {
        printf("[ResultTable][ERROR][init]: offset allocate error!\n");
        return -2;
    }
    offset = (int *)p;
    for (int ii = 0; ii < column_number; ii++)
    {
        offset[ii] = row_length;
        row_length += column_type[ii]->getTypeSize();
    }
    row_capicity = (int)(capicity / row_length);
    row_number = 0;
    return 0;
}

/** print */
int ResultTable::print(void)
{
    int row = 0;
    int ii = 0;
    char buffer[1024];
    char *p = NULL;
    while (row < row_number)
    {
        for (; ii < column_number - 1; ii++)
        {
            p = getRC(row, ii);
            column_type[ii]->formatTxt(buffer, p);
            printf("%s\t", buffer);
        }
        p = getRC(row, ii);
        column_type[ii]->formatTxt(buffer, p);
        printf("%s\n", buffer);
        row++;
        ii = 0;
    }
    return row;
}

/** dump result to fp*/
int ResultTable::dump(FILE *fp)
{
    int row = 0;
    int ii = 0;
    char *buffer;
    g_memory.alloc(buffer, 128);
    char *p = NULL;
    while (row < row_number)
    {
        for (; ii < column_number - 1; ii++)
        {
            p = getRC(row, ii);
            column_type[ii]->formatTxt(buffer, p);
            fprintf(fp, "%s\t", buffer);
        }
        p = getRC(row, ii);
        column_type[ii]->formatTxt(buffer, p);
        fprintf(fp, "%s\n", buffer);
        row++;
        ii = 0;
    }
    g_memory.free(buffer, 128);
    return row;
}

// this include checks, may decrease its speed
char *ResultTable::getRC(int row, int column)
{
    return buffer + row * row_length + offset[column];
}

/** write rc with data*/
int ResultTable::writeRC(int row, int column, void *data)
{
    char *p = getRC(row, column);
    if (p == NULL)
        return 0;
    return column_type[column]->copy(p, data);
}

/** shut memory */
int ResultTable::shut(void)
{
    // free memory
    if (buffer)
    {
        g_memory.free(buffer, buffer_size);
    }
    if (offset)
    {
        g_memory.free((char *)offset, offset_size);
    }
    return 0;
}

//---operators implementation---

//-  ---------Scan--------------
Scan::Scan(char *tablename)
{
    RowTable *table = (RowTable *)g_catalog.getObjByName(tablename);
    this->tabin[0] = table;
    this->tabout = table;
    this->col_num = table->getColumns().size();
}

bool Scan::init(void)
{
    this->current_row = 0;
    return true;
}

bool Scan::getNext(ResultTable *result)
{
    if (isEnd())
        return false;
    char *buffer;
    g_memory.alloc(buffer, 128);
    for (int current_col = 0; current_col < col_num; current_col++)
    {
        if (!this->tabin[0]->selectCol(current_row, current_col, buffer))
        {
            printf("DEBUG #7 RETURN FLASE%d %ld -%s-\n", current_col, tabin[0]->getColumns().size(), buffer);
            g_memory.free(buffer, 128);
            return false;
        }
        if (!result->writeRC(0, current_col, buffer))
        {
            printf("DEBUG #8 %d -%s-\n", current_col, buffer);
            g_memory.free(buffer, 128);
            return false;
        }
    }
    this->current_row++;
    g_memory.free(buffer, 128);
    return true;
}

bool Scan::isEnd(void)
{
    return (this->current_row == this->tabin[0]->getRecordNum());
}

bool Scan::close() { return true; }

//----------Filter--------------
Filter::Filter(Operator *op, Condition *cond)
{
    this->prior_op = op;
    this->cmp_method = cond->compare;
    this->tabin[0] = prior_op->getTableOut();
    this->tabout = this->tabin[0];

    RPattern in_RP = this->tabin[0]->getRPattern();
    int in_colnum = this->tabin[0]->getColumns().size();
    in_col_type = new BasicType *[in_colnum];
    for (int i = 0; i < in_colnum; i++)
        in_col_type[i] = in_RP.getColumnType(i);
    this->result.init(in_col_type, in_colnum);

    Object *col = g_catalog.getObjByName(cond->column.name);
    this->col_rank = this->tabout->getColumnRank(col->getOid());
    this->value_type = this->tabout->getRPattern().getColumnType(this->col_rank);
    this->value_type->formatBin(this->value, cond->value); //get fixed value
}

bool Filter::init()
{
    return prior_op->init();
}

bool Filter::getNext(ResultTable *result)
{
    bool flag = false;
    char *DEBUG_A;
    g_memory.alloc(DEBUG_A, 128);
    char *DEBUG_B;
    g_memory.alloc(DEBUG_B, 128);
    while (!flag)
    {
        if (prior_op->isEnd())
            break;
        if (!prior_op->getNext(&this->result))
            return false;
        char *cmpSrcA_ptr = this->result.getRC(0, this->col_rank); //variable value
        char *cmpSrcB_ptr = this->value;                           //fixed value
        this->value_type->formatTxt(DEBUG_A, cmpSrcA_ptr);
        this->value_type->formatTxt(DEBUG_B, cmpSrcB_ptr);

        if (this->cmp_method == LT)
            flag = this->value_type->cmpLT(cmpSrcA_ptr, cmpSrcB_ptr);
        else if (this->cmp_method == LE)
            flag = this->value_type->cmpLE(cmpSrcA_ptr, cmpSrcB_ptr);
        else if (this->cmp_method == EQ)
            flag = this->value_type->cmpEQ(cmpSrcA_ptr, cmpSrcB_ptr);
        else if (this->cmp_method == NE)
            flag = !this->value_type->cmpEQ(cmpSrcA_ptr, cmpSrcB_ptr);
        else if (this->cmp_method == GT)
            flag = this->value_type->cmpGT(cmpSrcA_ptr, cmpSrcB_ptr);
        else if (this->cmp_method == GE)
            flag = this->value_type->cmpGE(cmpSrcA_ptr, cmpSrcB_ptr);
        else
            flag = false;
    }
    //If condition meets, copy result from prior_op.result;
    if (flag)
    {
        char *buffer;
        for (int j = 0; j < (int)this->tabout->getColumns().size(); j++)
        {
            buffer = this->result.getRC(0L, j);
            if (!result->writeRC(0, j, buffer))
            {
                return false;
            }
        }
    }

    g_memory.free(DEBUG_A, 128);
    g_memory.free(DEBUG_B, 128);
    return flag;
}

bool Filter::isEnd()
{
    return prior_op->isEnd();
}

bool Filter::close()
{
    bool tmp = prior_op->close();
    delete prior_op;
    result.shut();
    delete[] in_col_type;
    return tmp;
}
//--------Project-------
Project::Project(Operator *op, int64_t col_tot, RequestColumn *cols_name)
{
    this->prior_op = op;
    this->col_tot = col_tot;
    this->tabin[0] = op->getTableOut();
    RPattern in_RP = this->tabin[0]->getRPattern();
    int in_colnum = this->tabin[0]->getColumns().size();

    in_col_type = new BasicType *[in_colnum];
    for (int i = 0; i < in_colnum; i++)
        in_col_type[i] = in_RP.getColumnType(i);
    this->result.init(in_col_type, in_colnum);

    for (int i = 0; i < col_tot; i++)
    {
        Object *col = g_catalog.getObjByName(cols_name[i].name);
        this->col_rank[i] = this->tabin[0]->getColumnRank(col->getOid());
    }

    string cname_head = "tmp_project_table";
    char *cname = constchar2char(strcat(constchar2char(cname_head.c_str()), to_string(project_tabout_id).c_str()));

    RowTable *project_table = (RowTable *)g_catalog.getObjByName(cname);
    if (project_table != NULL)
        project_table->shut();
    tabout = new RowTable(project_tabout_id++, cname);
    tabout->init();
    RPattern *newRPattern = &this->tabout->getRPattern();
    RPattern *oldRPattern = &this->tabin[0]->getRPattern();
    auto &cols_id = tabin[0]->getColumns();
    newRPattern->init(col_tot);
    for (int i = 0; i < col_tot; i++)
    {
        newRPattern->addColumn(oldRPattern->getColumnType(col_rank[i]));
        tabout->addColumn(cols_id[col_rank[i]]);
    }
}

bool Project::init()
{
    return prior_op->init();
}
bool Project::getNext(ResultTable *result)
{
    if (isEnd())
        return false;
    char *buffer;
    if (!this->prior_op->getNext(&this->result))
    {
        return false;
    }
    for (int i = 0; i < col_tot; i++)
    {
        buffer = this->result.getRC(0L, col_rank[i]);
        if (!result->writeRC(0, i, buffer))
        {
            return false;
        }
    }
    return true;
}
bool Project::isEnd()
{
    return prior_op->isEnd();
}
bool Project::close()
{
    bool tmp = prior_op->close();
    delete prior_op;
    result.shut();
    delete[] in_col_type;
    return tmp;
}

//----------HashJoin----------

HashJoin::HashJoin(int op_num, Operator **op, int cond_num, Condition *cond)
{
    this->op_num = op_num;
    if (op[1]->getTableOut()->getRecordNum() > op[0]->getTableOut()->getRecordNum())
    {
        Operator *op_switch = op[1];
        op[1] = op[0];
        op[0] = op_switch;
    }
    for (int i = 0; i < op_num; i++)
    {
        this->op[i] = op[i];
        tabin[i] = op[i]->getTableOut();
        col_num[i] = (int)tabin[i]->getColumns().size();
        tabout_colnum += col_num[i];
    }
    //this->cond_num = cond_num;
    char *col_a;
    char *col_b;
    col_a = cond->column.name;
    colA_oid = g_catalog.getObjByName(col_a)->getOid();
    col_b = cond->value;
    colB_oid = g_catalog.getObjByName(col_b)->getOid();

    //make sure colA belongs to table_0
    bool flag = true;
    auto &cols_id = tabin[0]->getColumns();
    for (int i = 0; i < col_num[0]; i++)
        if (cols_id[i] == colA_oid)
        {
            flag = false;
            break;
        }
    if (flag)
    {
        int64_t col_switch_tmp = colA_oid;
        colA_oid = colB_oid;
        colB_oid = col_switch_tmp;
    }
    colA_rank = tabin[0]->getColumnRank(colA_oid);
    colB_rank = tabin[1]->getColumnRank(colB_oid);
    //make up a temporary tabout
    string cname_head = "tmp_hashjoin_table";
    char *cname = constchar2char(strcat(constchar2char(cname_head.c_str()), to_string(tabout_id_hashjoin).c_str()));
    RowTable *hashjoin_table = (RowTable *)g_catalog.getObjByName(cname);
    if (hashjoin_table != NULL)
        hashjoin_table->shut();
    tabout = new RowTable(tabout_id_hashjoin++, cname);
    tabout->init();

    RPattern *newRPattern = &tabout->getRPattern();
    RPattern *oldRPattern = NULL;

    newRPattern->init(tabout_colnum);

    in_col_type = new BasicType *[tabout_colnum];
    BasicType *t;
    int cnt = 0;
    for (int i = 0; i < op_num; i++)
    {
        oldRPattern = &tabin[i]->getRPattern();
        auto &cols_id = tabin[i]->getColumns();
        for (int j = 0; j < col_num[i]; j++)
        {
            in_col_type[cnt++] = oldRPattern->getColumnType(j);
            t = oldRPattern->getColumnType(tabin[i]->getColumnRank(cols_id[j]));
            newRPattern->addColumn(t);
            tabout->addColumn(cols_id[j]);
        }
    }
    this->result.init(in_col_type, col_num[0]);
}

bool HashJoin::init(void)
{
    for (int i = 0; i < op_num; i++)
        if (!op[i]->init())
            return false;
    colB_type = new BasicType *[col_num[1]];
    for (int i = 0; i < col_num[1]; i++)
        colB_type[i] = tabin[1]->getRPattern().getColumnType(i);

    char *value;
    char *format_value;
    g_memory.alloc(format_value, 128);
    hash_table = new HashTable(200000, 10, 0);
    printf("DEBUG #6  %ld\n", op[1]->Ope_id);
    while (!op[1]->isEnd())
    {
        row_i[colB_row].init(colB_type, col_num[1]);
        op[1]->getNext(&row_i[colB_row]);

        value = row_i[colB_row].getRC(0, colB_rank);
        BasicType *this_type = tabin[1]->getRPattern().getColumnType(colB_rank);

        this_type->formatTxt(format_value, value);
        uint32_t hash_value = gethash(format_value, this_type);
        hash_table->add(hash_value, (char *)&row_i[colB_row]);

        colB_row++;
    }
    this->value_type = tabin[0]->getRPattern().getColumnType(colA_rank);
    g_memory.free(format_value, 128);

    return true;
}

bool HashJoin::getNext(ResultTable *result)
{
    bool flag = false;
    char *cmpSrcA_ptr;
    char *cmpSrcB_ptr;
    ResultTable *row_i;
    while (!flag)
    {
        if (op[0]->isEnd())
            break;
        if (!op[0]->getNext(&this->result))
            break;
        cmpSrcA_ptr = this->result.getRC(0, colA_rank);

        BasicType *value_type = tabin[0]->getRPattern().getColumnType(colA_rank);

        value_type->formatTxt(hashjoin_format_value, cmpSrcA_ptr);

        uint32_t hash_result = gethash(hashjoin_format_value, value_type);
        int64_t cmpSrcB_table_num = hash_table->probe(hash_result, hashjoin_cmpSrcB_tables, 2);
        for (int i = 0; i < cmpSrcB_table_num; i++)
        {
            row_i = (ResultTable *)hashjoin_cmpSrcB_tables[i];
            cmpSrcB_ptr = row_i->getRC(0, colB_rank);
            value_type->formatTxt(hashjoin_format_value, cmpSrcB_ptr);
            if (this->value_type->cmpEQ(cmpSrcA_ptr, cmpSrcB_ptr))
            {
                flag = true;
                break;
            }
        }
        if (flag)
            break;
    }
    if (flag)
    {
        char *buffer;
        for (int j = 0; j < col_num[0]; j++)
        {
            buffer = this->result.getRC(0L, j);
            if (!result->writeRC(0, j, buffer))
            {
                return false;
            }
        }
        for (int j = 0; j < col_num[1]; j++)
        {
            buffer = row_i->getRC(0L, j);
            if (!result->writeRC(0, col_num[0] + j, buffer))
            {
                return false;
            }
        }
    }
    return flag;
}

bool HashJoin::close(void)
{
    delete hash_table;
    result.shut();
    delete[] in_col_type;
    for (int i = 0; i < colB_row; i++)
    {
        row_i[i].shut();
    }
    for (int i = 0; i < op_num; i++)
        if (!op[i]->close())
            return false;
    for (int i = 0; i < op_num; i++)
        delete op[i];
    delete[] colB_type;
    return false;
}

bool HashJoin::isEnd(void)
{
    return op[0]->isEnd();
}

//------------------OrderBy------------------------------

OrderBy::OrderBy(Operator *op, int64_t Orderbynum, RequestColumn *cols_name)
{
    this->prior_op = op;
    this->tabin[0] = op->getTableOut();
    this->tabout = this->tabin[0];
    this->col_num = this->tabin[0]->getColumns().size();
    this->orderbynum = Orderbynum;
    RPattern in_RP = this->tabin[0]->getRPattern();
    in_col_type = new BasicType *[this->col_num];
    int64_t in_col_num = this->tabin[0]->getColumns().size();
    for (int i = 0; i < this->col_num; i++)
        this->in_col_type[i] = in_RP.getColumnType(i);
    this->result.init(in_col_type, in_col_num);
    this->re.init(in_col_type, in_col_num, 1024 * 32);

    this->row_length = in_RP.getRowSize();
    for (int i = 0; i < orderbynum; i++)
    {
        Object *col = g_catalog.getObjByName(cols_name[i].name);
        this->cmp_col_rank[i] = this->tabin[0]->getColumnRank(col->getOid());
        this->cmp_col_type[i] = in_RP.getColumnType(cmp_col_rank[i]);
        this->cmp_col_offset[i] = in_RP.getColumnOffset(cmp_col_rank[i]);
    }
}
bool OrderBy::init()
{
    char *buffer;
    int i = 0;
    prior_op->init();
    while (!prior_op->isEnd() && prior_op->getNext(&this->result))
    {
        for (int j = 0; j < this->col_num; j++)
        {
            buffer = result.getRC(0, j);
            re.writeRC(i, j, buffer);
        }
        i++;
    }
    this->record_size = i;
    quick_sort(re.buffer, 0, record_size - 1);
    index = 0;
    return true;
}

void OrderBy::quick_sort(char *buffer, int64_t left, int64_t right)
{
    if (left < right)
    {
        char *key = (char *)malloc(row_length);
        memcpy(key, buffer + left * row_length, row_length);
        int64_t low = left;
        int64_t high = right;
        while (low < high)
        {
            while (low < high && cmp(buffer + high * row_length, key))
                high--;
            memcpy(buffer + low * row_length, buffer + high * row_length, row_length);

            while (low < high && cmp(key, buffer + low * row_length))
                low++;
            memcpy(buffer + high * row_length, buffer + low * row_length, row_length);
        }
        memcpy(buffer + low * row_length, key, row_length);
        quick_sort(buffer, left, low - 1);
        quick_sort(buffer, low + 1, right);
        free(key);
    }
}
void OrderBy::bubble_sort(char *buffer)
{
    int i;
    char *temp = (char *)malloc(row_length);
    for (i = 0; i < record_size; i++)
    {
        for (int j = i; j < record_size; j++)
        {
            if (cmp(buffer + row_length * i, buffer + row_length * j))
            {
                memcpy(temp, buffer + i * row_length, row_length);
                memcpy(buffer + i * row_length, buffer + j * row_length, row_length);
                memcpy(buffer + j * row_length, temp, row_length);
            }
        }
    }
    free(temp);
}
int OrderBy::cmp(void *l, void *r)
{
    int i;
    for (i = 0; i < orderbynum;)
    {
        auto p = l + cmp_col_offset[i];
        auto q = r + cmp_col_offset[i];
        if (this->cmp_col_type[i]->cmpEQ(p, q))
            i++;
        else if (this->cmp_col_type[i]->cmpGT(p, q))
            return 2;
        else
            return 0;
    }
    return 1;
}

bool OrderBy::getNext(ResultTable *result)
{
    if (this->isEnd())
        return false;
    char *buffer;
    for (int i = 0; i < col_num; i++)
    {
        buffer = this->re.getRC(this->index, i);
        if (!result->writeRC(0, i, buffer))
        {
            return false;
        }
    }
    this->index++;
    return true;
}
bool OrderBy::isEnd()
{
    return index == record_size;
}
bool OrderBy::close()
{
    int t = prior_op->close();
    delete prior_op;
    result.shut();
    re.shut();
    delete[] in_col_type;
    return t;
}
//----------------GroupBy-----------------

GroupBy::GroupBy(Operator *op, int groupby_num, RequestColumn req_col[4])
{
    this->prior_op = op;
    this->tabin[0] = op->getTableOut();
    this->tabout = this->tabin[0];
    RPattern temp_RP = this->tabin[0]->getRPattern();
    this->row_size = temp_RP.getRowSize();
    this->col_num = this->tabout->getColumns().size();
    for (int i = 0; i < groupby_num; i++)
    {
        if (req_col[i].aggrerate_method == NONE_AM)
        {
            this->non_aggre_off[non_aggre_index] = i;
            this->non_aggre_type[non_aggre_index] = tabout->getRPattern().getColumnType(i);
            this->non_aggre_num++;
            this->non_aggre_index++;
        }
        else
        {
            this->aggre_off[aggre_index] = i;
            this->aggre_type[aggre_index] = tabout->getRPattern().getColumnType(i);
            this->aggre_method[aggre_index] = req_col[i].aggrerate_method;
            this->aggre_num++;
            this->aggre_index++;
        }
    }
}

bool GroupBy::init()
{
    if (!prior_op->init())
        return false;
    //------Result Tables------
    RPattern in_RP = tabin[0]->getRPattern();
    int in_colnum = tabin[0]->getColumns().size();
    BasicType **in_col_type;
    in_col_type = new BasicType *[in_colnum];
    for (int i = 0; i < in_colnum; i++)
        in_col_type[i] = in_RP.getColumnType(i);
    this->temp_result.init(in_col_type, in_colnum, 524288);
    this->temp_one.init(in_col_type, in_colnum);
    //------hash table------
    HashTable *hstable = new HashTable(1000000, 4, 0);
    int64_t hash_count = 0;

    char **probe_result = (char **)malloc(4 * round2(row_size));
    char *src;
    int64_t temp_offset = 0;
    int64_t pattern_count[32768];
    int64_t key;
    char temp_buffer[1024];

    for (int i = 0; i < 32768; i++)
        pattern_count[i] = 0;
    while (!prior_op->isEnd() && prior_op->getNext(&temp_one))
    {
        //------generate the hash key------
        key = 0;
        temp_offset = 0;
        for (int i = 0; i < non_aggre_num; i++)
        {
            src = temp_one.getRC(0, non_aggre_off[i]);
            temp_one.column_type[non_aggre_off[i]]->formatTxt(temp_buffer + temp_offset, src);
            temp_offset += non_aggre_type[i]->getTypeSize();
        }
        key = gethash(temp_buffer, NULL);
        //-----look up in hashtable-----
        if (hstable->probe(key, probe_result, 4) > 0)
        {
            pattern_count[(uint64_t)probe_result[0]]++;
            for (int i = 0; i < aggre_num; i++)
            {
                aggre(aggre_method[i], (uint64_t)probe_result[0], i);
            }
        }
        else
        {
            hstable->add(key, (char *)hash_count);
            for (int j = 0; j < col_num; j++)
            {
                src = temp_one.getRC(0, j);
                temp_result.writeRC(hash_count, j, src);
            }
            temp_result.row_number++;
            pattern_count[hash_count]++;
            hash_count++;
        }
    }
    float avg_result = 0;
    for (int j = 0; j < hash_count; j++)
    {
        for (int k = 0; k < aggre_num; k++)
        {
            auto datain = temp_result.getRC(j, aggre_off[k]);
            switch (aggre_method[k])
            {
            case COUNT:
                aggre_type[k]->copy(datain, &pattern_count[j]);
                break;
            case AVG:
                avg_result = *(float *)datain;
                memcpy(datain, (void *)&avg_result, 4);
                break;
            default:
                break;
            }
        }
    }
    free(probe_result);
    return true;
}

bool GroupBy::getNext(ResultTable *result)
{
    if (this->index >= temp_result.row_number)
        return false;
    for (int j = 0; j < col_num; j++)
    {
        char *buf = temp_result.getRC(this->index, j);
        if (!result->writeRC(0, j, buf))
            return false;
    }
    index++;
    return true;
}

bool GroupBy::isEnd()
{
    return prior_op->isEnd();
}

bool GroupBy::close()
{
    bool tmp = prior_op->close();
    delete prior_op;
    temp_one.shut();
    temp_result.shut();
    return tmp;
}

bool GroupBy::aggre(AggrerateMethod method, uint64_t probe_result, int agg_i)
{
    auto datain = temp_one.getRC(0, aggre_off[agg_i]);
    auto dataout = temp_result.getRC(probe_result, aggre_off[agg_i]);
    switch (method)
    {
    case SUM:
    case AVG:
    {
        switch (aggre_type[agg_i]->getTypeCode())
        {
        case INT8_TC:
        {
            int8_t agg_result = *(int8_t *)datain + *(int8_t *)dataout;
            memcpy(dataout, (void *)&agg_result, 1);
            break;
        }
        case INT16_TC:
        {
            int16_t agg_result = *(int16_t *)datain + *(int16_t *)dataout;
            memcpy(dataout, (void *)&agg_result, 2);
            break;
        }
        case INT32_TC:
        {
            int32_t agg_result = *(int32_t *)datain + *(int32_t *)dataout;
            memcpy(dataout, (void *)&agg_result, 4);
            break;
        }
        case INT64_TC:
        {
            int64_t agg_result = *(int64_t *)datain + *(int64_t *)dataout;
            memcpy(dataout, (void *)&agg_result, 8);
            break;
        }
        case FLOAT32_TC:
        {
            float agg_result = *(float *)datain + *(float *)dataout;
            memcpy(dataout, (void *)&agg_result, 4);
            break;
        }
        case FLOAT64_TC:
        {
            double agg_result = *(double *)datain + *(double *)dataout;
            memcpy(dataout, (void *)&agg_result, 8);
            break;
        }
        default:
            return false;
        }
        return true;
    }
    case MAX:
        if (aggre_type[agg_i]->cmpLT(dataout, datain))
            aggre_type[agg_i]->copy(dataout, datain);
        break;
    case MIN:
        if (aggre_type[agg_i]->cmpLT(datain, dataout))
            aggre_type[agg_i]->copy(dataout, datain);
        break;
    default:
        break;
    }
}