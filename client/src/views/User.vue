<template>
    <div>

        <div style="padding: 10px 0;">
            <el-input style="width: 200px" suffix-icon="el-icon-search" placeholder="搜索用户名" v-model="username"></el-input>
            <el-button style="margin-left: 5px;" type="primary" @click="load">搜索</el-button>
            <el-button @click="reset">重置</el-button>
        </div>

        <div style="margin: 10px 0;">
            <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>

            <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                icon-color="red" title="您确定批量删除这些数据吗？" @confirm="delBatch">
                <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
            </el-popconfirm>
            <el-upload action="http://localhost:8088/user/import" :show-file-list="false" accept=".xlsx"
                :on-success="handleExcelImportSuccess" style="display: inline-block;">
                <el-button type="primary" class="ml-5">导入 <i class="el-icon-upload2"></i></el-button>
            </el-upload>
            <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-download"></i></el-button>
        </div>

        <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
            @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55">
            </el-table-column>
            <el-table-column prop="id" label="ID" width="80">
            </el-table-column>
            <el-table-column prop="username" label="用户名" width="100">
            </el-table-column>
            <el-table-column prop="nickname" label="昵称" width="100">
            </el-table-column>
            <el-table-column prop="role" label="角色" width="100px">
            </el-table-column>
            <el-table-column prop="email" label="邮箱">
            </el-table-column>
            <el-table-column prop="phone" label="电话">
            </el-table-column>
            <el-table-column prop="address" label="地址">
            </el-table-column>
            <el-table-column prop="defaults" label="违约次数" width="80px">
            </el-table-column>
            <el-table-column prop="option" label="操作">
                <template slot-scope="scope">
                    <el-button @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>

                    <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                        icon-color="red" title="您确定删除吗？" @confirm="handleDelete(scope.row.id)">
                        <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>

                    </el-popconfirm>
                </template>
            </el-table-column>
        </el-table>

        <div style="padding: 10px 0;">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                :page-sizes="[2, 5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="total">
            </el-pagination>
        </div>

        <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="30%">
            <el-form label-width="80px" size="small">
                <el-form-item label="用户名">
                    <el-input v-model="form.username" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="角色">
                    <el-select clearable v-model="form.role" placeholder="请选择角色" style="width: 100%">
                        <el-option v-for="item in roles" :key="item.name" :label="item.name" :value="item.flag"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="昵称">
                    <el-input v-model="form.nickname" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="form.email" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="电话">
                    <el-input v-model="form.phone" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="地址">
                    <el-input v-model="form.address" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="save">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name: "User",
    data() {
        return {
            tableData: [],
            total: 0,
            pageNum: 1,
            pageSize: 10,
            username: "",
            form: {},
            dialogFormVisible: false,
            multipleSelection: [],
            headerBg: 'headerBg',
            roles: [],
        }
    },
    created() {
        // 请求分页查询数据
        this.load()
    },
    methods: {
        load() {
            this.request.get("/user/page", {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize,
                    username: this.username
                }
            }).then(res => {
                console.log(res)
                this.tableData = res.data.records
                console.log(this.tableData)
                this.total = res.data.total
            })

            this.request.get("/role").then(res => {
                this.roles = res.data
            })
        },
        handleSizeChange(pageSize) {
            this.pageSize = pageSize
            this.load()
        },
        handleCurrentChange(pageNum) {
            this.pageNum = pageNum
            this.load()
        },
        handleAdd() {
            this.dialogFormVisible = true
            this.form = {}
        },
        reset() {
            this.username = ""
            this.load()
        },
        save() {
            this.request.post("/user", this.form).then(res => {
                if (res.code === '200') {
                    this.$message.success("保存成功")
                    this.dialogFormVisible = false
                    this.load()
                } else {
                    this.$message.error("保存失败")
                }
            })
        },
        handleEdit(row) {
            this.form = row
            this.dialogFormVisible = true
        },
        handleDelete(id) {
            this.request.delete("/user/" + id).then(res => {
                if (res.code === '200') {
                    this.$message.success("删除成功")
                    this.load()
                } else {
                    this.$message.error("删除失败")
                }
            })
        },
        handleSelectionChange(val) {
            console.log(val)
            this.multipleSelection = val
        },
        delBatch() {
            // 扁平化 [{}, {}, {}] => [1, 2, 3]
            let ids = this.multipleSelection.map(v => v.id)
            this.request.post("/user/del/batch", ids).then(res => {
                if (res.code === '200') {
                    this.$message.success("批量删除成功")
                    this.load()
                } else {
                    this.$message.error("批量删除失败")
                }
            })
        },
        exp() {
            window.open("http://localhost:8088/user/export")
        },
        handleExcelImportSuccess() {
            this.$message.success("导入成功")
            this.load()
        }
    }
}
</script>

<style scoped>
.headerBg {
    background: #eee !important;
}
</style>
