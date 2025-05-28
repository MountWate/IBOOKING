<template>
<div style="height: 100vh">
    <el-container style="min-height: 100vh; border: 1px solid #eee">

        <el-aside :width="sideWidth + 'px'" style="background-color: rgb(238, 241, 246); 
            box-shadow: 2px 0 6px rgb(0 21 41 / 35%);">
            <Aside :isCollapse="isCollapse" :logoTextShow="logoTextShow" />
        </el-aside>

        <el-container>
            <el-header style="border-bottom: 1px solid #ccc;">
                <Header :collapseBtnClass="collapseBtnClass" :collapse="collapse" />
            </el-header>

            <el-main>
                <!-- 表示当前页面的子路由会在route-view展示 -->
                <router-view />
            </el-main>
        </el-container>
    </el-container>
</div>
</template>

<script>
import Aside from '../components/Aside.vue';
import Header from '../components/Header.vue';

export default {
    name: "Home",
    data() {
        const item = {
            date: '2016-05-02',
            name: '苏永甫',
            address: '上海市普陀区金沙江路 1518 弄'
        };
        return {
            collapseBtnClass: 'el-icon-s-fold',
            isCollapse: false,
            sideWidth: 200,
            logoTextShow: true
        }
    },
    components: {
        Aside,
        Header
    },
    methods: {
        collapse() { // 点击收缩按钮触发
            this.isCollapse = !this.isCollapse
            if (this.isCollapse) {
                this.sideWidth = 64
                this.collapseBtnClass = 'el-icon-s-unfold',
                    this.logoTextShow = false
            } else { // 展开
                this.sideWidth = 200
                this.collapseBtnClass = 'el-icon-s-fold',
                    this.logoTextShow = true
            }
        }
    }
};
</script>

<style>
.el-header {
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
}

.el-aside {
    color: #333;
}

.headerBg {
    background: #eee !important;
}
</style>
