<template>
    <div>
        <div style="padding: 10px 0;">
            <el-input style="width: 200px" suffix-icon="el-icon-search" placeholder="搜索用户名" v-model="name"></el-input>
            <el-button style="margin-left: 5px;" type="primary" @click="load">搜索</el-button>
            <el-button @click="reset">重置</el-button>
        </div>

        <div style="margin: 10px 0;">
            <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>

            <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                icon-color="red" title="您确定批量删除这些数据吗？" @confirm="delBatch">
                <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
            </el-popconfirm>
            <el-upload action="http://localhost:8088/room/import" :show-file-list="false" accept=".xlsx"
                :on-success="handleExcelImportSuccess" style="display: inline-block;">
                <el-button type="primary" class="ml-5">导入 <i class="el-icon-upload2"></i></el-button>
            </el-upload>
            <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-download"></i></el-button>
        </div>

        <el-table :data="tableData" border stripe @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55">
            </el-table-column>
            <el-table-column prop="id" label="教室ID">
            </el-table-column>
            <el-table-column prop="name" label="教室名称">
            </el-table-column>
            <el-table-column prop="type" label="教室类型">
            </el-table-column>
            <el-table-column label="是否可用">
                <template slot-scope="scope">
                    <el-switch v-model="scope.row.available" active-color="#13ce66" inactive-color="#ccc"
                        disabled></el-switch>
                </template>
            </el-table-column>
            <el-table-column prop="openTime" label="开放时间">
            </el-table-column>
            <el-table-column prop="closeTime" label="关闭时间">
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

        <el-dialog title="教室信息" :visible.sync="dialogFormVisible" width="50%">

            <el-form label-width="80px" size="small">
                <el-form-item label="教室名称" style="width: 295px;">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="教室类型" style="width:400px;">
                    <el-select v-model="form.type" placeholder="请选择">
                        <el-option v-for="item in classroomTypes" :key="item.value" :label="item.label" :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="是否可用">
                    <template slot-scope="">
                        <el-switch v-model="form.available" active-color="#13ce66" inactive-color="#ccc"
                            @change="changeEnable(form.id)"></el-switch>
                    </template>
                </el-form-item>
                <el-form-item label="开放时间" style="width: 350px;">
                    <el-time-select v-model="form.openTime" :picker-options="{
                        start: '00:00',
                        step: '01:00',
                        end: '24:00'
                    }" style="width: 80%;">
                    </el-time-select>
                </el-form-item>
                <el-form-item label="关闭时间" style="width: 350px;">
                    <el-time-select v-model="form.closeTime" :picker-options="{
                        start: '00:00',
                        step: '01:00',
                        end: '24:00'
                    }" style="width: 80%;">
                    </el-time-select>
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
    name: "Room",
    data() {
        return {
            name: "",
            pageNum: 1,
            pageSize: 20,
            total: 10,
            form: {},
            tableData: [],
            dialogFormVisible: false,
            multipleSelection: [],
            classroomTypes: [{
                value: '0',
                label: '小教室'
            },
            {
                value: '1',
                label: '大教室'
            },
            {
                value: '2',
                label: '阅览室'
            },
            {
                value: '3',
                label: '图书馆'
            }
            ],

        }
    },
    created() {
        this.load()
    },
    methods: {
        load() {
            this.request.get("/room/check_room", {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize,
                    name: this.name
                }
            }).then(res => {
                this.tableData = res.data.records
                this.total = res.data.total
            })

        },
        changeName() {
            console.log(1)
            this.form.name = label + " " + this.form.name.split(" ")[1]
        },
        reset() {
            this.name = ""
            this.load()
        },
        handleSelectionChange(val) {
            console.log(val)
            this.multipleSelection = val
        },
        handleAdd() {
            this.dialogFormVisible = true
            this.form = {}
        },
        delBatch() {
            let ids = this.multipleSelection.map(v => v.id)
            this.request.post("/room/del/batch", ids).then(res => {
                if (res.code === '200') {
                    this.$message.success("批量删除成功")
                    this.load()
                } else {
                    this.$message.error("批量删除失败")
                }
            })
        },
        handleExcelImportSuccess() {
        },
        exp() {

        },
        handleEdit(row) {
            this.dialogFormVisible = true
            this.form = row
            console.log(row)
        },
        handleDelete(id) {
            this.request.delete("/room/" + id).then(res => {
                if (res.code === '200') {
                    this.$message.success("删除成功")
                    this.load()
                } else {
                    this.$message.error("删除失败")
                }
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
        save() {
            const startHour = parseInt(this.form.openTime.split(":")[0])
            const EndHour = parseInt(this.form.closeTime.split(":")[0])
            if (startHour < EndHour) {
                if (this.form.id === undefined) {
                    this.request.post("/room/create_room", this.form).then(res => {
                        if (res.code === '200') {
                            this.$message.success("保存成功")
                            this.dialogFormVisible = false
                            this.load()
                        } else {
                            this.$message.error("保存失败")
                        }
                    })
                } else {
                    this.request.post("/room/update_room", this.form).then(res => {
                        if (res.code === '200') {
                            this.$message.success("保存成功")
                            this.dialogFormVisible = false
                            this.load()
                        } else {
                            this.$message.error("保存失败")
                        }
                    })
                }
            } else {
                this.$message.error("时间选择有误")
            }
        },
        changeEnable() {

        }

    }
}
</script>

