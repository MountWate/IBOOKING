<template>
    <div>

        <div style="padding: 10px 0;">
            <el-input style="width: 200px" suffix-icon="el-icon-search" placeholder="搜索名称" v-model="name"></el-input>
            <el-button style="margin-left: 5px;" type="primary" @click="load">搜索</el-button>
            <el-button @click="reset">重置</el-button>
        </div>

        <div style="margin: 10px 0;">
            <el-button type="primary" @click="handleAdd(null)">新增 <i class="el-icon-circle-plus-outline"></i></el-button>

            <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                icon-color="red" title="您确定批量删除这些数据吗？" @confirm="delBatch">
                <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
            </el-popconfirm>

        </div>

        <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" row-key="id" default-expand-all
            @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column prop="id" label="ID" width="80"></el-table-column>
            <el-table-column prop="name" label="名称" width="140"></el-table-column>
            <el-table-column prop="path" label="路径" width="120"></el-table-column>
            <el-table-column prop="pagePath" label="页面路径" width="120"></el-table-column>
            <el-table-column label="图标" class-name="fontSize18" align="center" label-class-name="fontSize12">
                <template slot-scope="scope">
                    <span :class="scope.row.icon" />
                </template>
            </el-table-column>
            <el-table-column prop="description" label="描述"></el-table-column>

            <el-table-column prop="option" label="操作" width="300" align="center">
                <template slot-scope="scope">
                    <el-button type="primary" @click="handleAdd(scope.row.id)"
                        v-if="!scope.row.pid && !scope.row.path">新增子菜单 <i class="el-icon-plus"></i></el-button>
                    <el-button @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
                    <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                        icon-color="red" title="您确定删除吗？" @confirm="handleDelete(scope.row.id)">
                        <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>

                    </el-popconfirm>
                </template>
            </el-table-column>
        </el-table>



        <el-dialog title="菜单信息" :visible.sync="dialogFormVisible" width="30%">
            <el-form label-width="80px" size="small">
                <el-form-item label="名称">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="路径">
                    <el-input v-model="form.path" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="页面路径">
                    <el-input v-model="form.pagePath" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="图标">
                    <el-select clearable v-model="form.icon" placeholder="请选择" style="width: 100%">
                        <el-option v-for="item in options" :key="item.name" :label="item.name" :value="item.value">
                            <i :class="item.value" /> {{ item.name }}
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="描述">
                    <el-input v-model="form.description" autocomplete="off"></el-input>
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
    name: "Menu",
    data() {
        return {
            tableData: [],
            total: 0,
            pageNum: 1,
            pageSize: 10,
            name: "",
            form: {},
            dialogFormVisible: false,
            multipleSelection: [],
            headerBg: 'headerBg',
            options: []
        }
    },
    created() {
        // 请求分页查询数据
        this.load()
    },
    methods: {
        load() {
            this.request.get("/menu", {
                params: {
                    name: this.name
                }
            }).then(res => {
                console.log(res)
                this.tableData = res.data
            })

            // 请求图标的数据
            this.request.get("/menu/icons").then(res => {
                this.options = res.data
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
        handleAdd(pid) {
            this.dialogFormVisible = true
            this.form = {}
            if (pid) {
                this.form.pid = pid
            }
        },
        reset() {
            this.name = ""
            this.load()
        },
        save() {
            this.request.post("/menu", this.form).then(res => {
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
            this.request.delete("/menu/" + id).then(res => {
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
            this.request.post("/menu/del/batch", ids).then(res => {
                if (res.code === '200') {
                    this.$message.success("批量删除成功")
                    this.load()
                } else {
                    this.$message.error("批量删除失败")
                }
            })
        },
        exp() {
            window.open("http://localhost:8088/menu/export")
        },
        handleExcelImportSuccess() {
            this.$message.success("导入成功")
            this.load()
        }
    }
}
</script>

<style>
.headerBg {
    background: #eee !important;
}
.fontSize18 {
    font-size: 18px;
}

.fontSize12 {
    font-size: 12px;
}
</style>
