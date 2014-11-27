<#include "/view/main/layout.tpl.ftl"/>
<#include "/view/main/pagination.tpl.ftl"/>
<!-- build:js -->
<script data-main="/javascript/app/order/init" src="/webjars/requirejs/2.1.14/require.min.js" charset="utf-8"></script>
<!-- endbuild -->
<@layout activebar="branch" html_title="全部订单">
<div class="row">
    <div class="col-md-8">

        <form class="form-horizontal branch" role="form" action="/order/branch" method="get">
            <div class="form-group">
                <label class="col-sm-2 control-label" style="text-align: left;width: 100px;">区域/支行:</label>

                <div class="col-sm-8">
                    <select name="region_id" select="${region_id!}">
                        <#if regions?? && regions?size gt 0>
                            <#list regions as region>
                                <option value="${region.id}">${region.name}</option>
                            </#list>
                        </#if>
                        <option value="" selected="selected">请选择</option>
                    </select>
                    <select name="order.branch_id" select="${(order.branch_id)!}">
                        <option value="" selected="selected">请选择</option>
                    </select>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-default">搜索</button>
                    </div>
                </div>
            </div>
        </form>
        <ul class="nav nav-tabs menu-tabs" role="tablist" style="margin-bottom: 10px">
            <li role="presentation" class="<#if order.state??><#else>active</#if>"><a href="#">全部</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==0>active</#if>"><a href="#"
                                                                                                 value="0">已创建</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==1>active</#if>"><a href="#"
                                                                                                 value="1">已接收</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==2>active</#if>"><a href="#"
                                                                                                 value="2">已发货</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==3>active</#if>"><a href="#"
                                                                                                 value="3">已收货</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==4>active</#if>"><a href="#"
                                                                                                 value="4">已付款</a></li>
            <li role="presentation" class="<#if order.state?? && order.state==-1>active</#if>"><a href="#" value="-1">已取消</a>
            </li>
        </ul>
        <table class="table table-bordered table-hover"
               style="<#if data_type?? && data_type?contains('order')>width: 1400px;</#if>">
            <thead>
            <tr>
                <th>订单编号</th>
                <th>产品</th>
                <th>数量</th>
                <th>总价</th>
                <th>下单时间</th>
                <th>发货时间</th>
                <th>状态</th>
                <@shiro.hasPermission name="P_ORDER_CONTROL">
                    <th>操作</th>
                </@shiro.hasPermission>
            </tr>
            </thead>
            <tbody>
                <#if orders?? && orders.list?size gt 0>
                    <#list orders.list as order>
                    <tr>
                        <td>${order.code}</td>
                        <td>
                            <#list order.products as product>
            ${product.name}
          </#list>
                        </td>
                        <td>
                            <#if order.products?? && order.products?size gt 0>
              <#list order.products as product>
                            ${product.num}
                            </#list>
            </#if>
                        </td>
                        <td>${order.actual_pay}</td>
                        <td>${order.created_at}</td>
                        <td>${order.delivered_at}</td>
                        <td>
                            <#if states?? && states?size gt 0>
          <#list states as state>
                                <#if order.state==state.value>
                                ${state.name}
                                </#if>
                            </#list>
        </#if>
                        </td>
                        <@shiro.hasPermission name="P_ORDER_CONTROL">
                            <td>
                                <#if order.state == 0>
                                    <a class="receive" orderid="${order.id}" href="#confirmModal" data-toggle="modal"
                                       data-label="接收" data-content="确认接收？">接收</a>
                                </#if>
                                <#if order.state == 1>
                                    <a class="deliver" orderid="${order.id}" href="#confirmModal" data-toggle="modal"
                                       data-label="发货" data-content="确认发货？">发货</a>
                                </#if>
                            </td>
                        </@shiro.hasPermission>
                    </tr>
                    </#list>
                </#if>
            </tbody>
        </table>
        <#if orders?? && orders.list?size gt 0>
            <@paginate currentPage=orders.pageNumber totalPage=orders.totalPage actionUrl=_localUri urlParas=_localParas className="pagination"/>
        </#if>
    </div>
    <div class="col-md-4"><#include "/view/main/tip.tpl.ftl"></div>
</div>
</@layout>