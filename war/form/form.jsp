<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page language="java" contentType="text/html; charset=windows-1252" pageEncoding="windows-1252"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserService"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>Delivery Pizza Cloud</title>
	<link rel="stylesheet" type="text/css" href="/form/view.css" media="all"/>
	<link rel="stylesheet" type="text/css" href="/css/jquery-ui-1.8.19.custom.css" media="all"/>
	
	<style type="text/css">
.classname {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #cfcdcf) );
	background:-moz-linear-gradient( center top, #ededed 5%, #cfcdcf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#cfcdcf');
	background-color:#ededed;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #b3afb3;
	display:inline-block;
	color:#d63737;
	font-family:arial;
	font-size:15px;
	font-weight:bold;
	padding:9px 24px;
	text-decoration:none;
	text-shadow:1px 1px 0px #ffffff;
}.classname:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #cfcdcf), color-stop(1, #ededed) );
	background:-moz-linear-gradient( center top, #cfcdcf 5%, #ededed 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#cfcdcf', endColorstr='#ededed');
	background-color:#cfcdcf;
}.classname:active {
	position:relative;
	top:1px;
}
/* This imageless css button was generated by CSSButtonGenerator.com */
</style>
	
	<script type="text/javascript" src="/form/view.js"></script>
	<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="/js/jquery.form.js"></script>
	<script type="text/javascript" src="/js/jquery-ui-1.8.19.custom.min.js"></script>
	
	<script>
				
		// prepare the form when the DOM is ready 
		$(document).ready(function() {
		    var options = { 
		        target:        '#response',   // target element(s) to be updated with server response 
		        beforeSubmit:  showRequest,  // pre-submit callback 
		        success:       showResponse,  // post-submit callback 
		  		error:		   errorResponse,
		  		clearForm: true,        // clear all form fields after successful submit 
			    resetForm: true,       // reset the form after successful submit
			    timeout: 45000,		// 45 seconds timeout
		        // other available options: 
		        //url:       url         // override for form's 'action' attribute 
		        //type:      type        // 'get' or 'post', override for form's 'method' attribute 
		        //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
		       
		 
		        // $.ajax options can be used here too, for example: 
		         
		    }; 
		 
		    // bind form using 'ajaxForm' 
		    $('#formPedido').ajaxForm(options); 
		}); 
		 
		// pre-submit callback 
		function showRequest(formData, jqForm, options) { 
		    // formData is an array; here we use $.param to convert it to a string to display it 
		    // but the form plugin does this for you automatically when it submits the data 
		    var queryString = $.param(formData); 
		 
		    // jqForm is a jQuery object encapsulating the form element.  To access the 
		    // DOM element for the form do this: 
		    // var formElement = jqForm[0]; 
		 
		    $( "#loading" ).dialog({				
				modal: true
			}); 
		 
		    // here we could return false to prevent the form from being submitted; 
		    // returning anything other than false will allow the form submit to continue 
		    return true; 
		} 
		 
		// post-submit callback 
		function showResponse(responseText, statusText, xhr, $form)  { 
			 
			 $( "#loading" ).dialog( "close" );
			// for normal html responses, the first argument to the success callback 
		    // is the XMLHttpRequest object's responseText property 
		 
		    // if the ajaxForm method was passed an Options Object with the dataType 
		    // property set to 'xml' then the first argument to the success callback 
		    // is the XMLHttpRequest object's responseXML property 
		 
		    // if the ajaxForm method was passed an Options Object with the dataType 
		    // property set to 'json' then the first argument to the success callback 
		    // is the json data object returned by the server
		   
			$( "#response" ).dialog({
				buttons: {
					"Ok": function() {
						document.location = '/';
						//$( this ).dialog( "close" );
					}
				},
				
				modal: true
			});
		    
		} 
		
		function errorResponse() {
			$( "#loading" ).dialog( "close" );
			
			$( "#msg_erro" ).dialog({
				buttons: {
					"Ok": function() {
						$( this ).dialog( "close" );
					}
				},
				
				modal: true
			});
		}
		
	</script>	
	
</head>
<body id="main_body">
	
			
	<img id="top" src="/form/top.png" alt=""/>
		<div id="form_container">
				
			<div class="form_description" align="right" style="padding: 5px;">
				<h3>
					<%
					    UserService userService = UserServiceFactory.getUserService();
					    User user = userService.getCurrentUser();
					    String disableValue = "";
					    if (user != null) {
					%>
					<p>Ol&aacute;, <%= user.getNickname() %>! (
					<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">log out</a>.)</p>
					<%
					    } else {
					    	disableValue = "disabled=\"disabled\"";
					%>
					<p>Ol&aacute;!
					Fa�a <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Log in</a>
					para realizar o pedido</p>
					<%
					    }
					%>
				</h3>
			</div>
			
			
			<form id="formPedido" class="appnitro" method="get" action="/pedidoService">
				<div class="form_description">
					<!-- ============================= -->
					<!-- 
					<div id="fb-root"></div>
				      <script>
				        (function(d, s, id) {
				          var js, fjs = d.getElementsByTagName(s)[0];
				          if (d.getElementById(id)) {return;}
				          js = d.createElement(s); js.id = id;
				          js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
				          fjs.parentNode.insertBefore(js, fjs);
				        }(document, 'script', 'facebook-jssdk'));
				      </script>
				    <div class="fb-like"></div>  
				     -->
				    <!-- Coloque esta tag onde voc� deseja que o bot�o +1 seja renderizado -->
					<g:plusone annotation="inline"></g:plusone>
					
					<!-- Coloque esta chamada de renderiza��o conforme necess�rio -->
					<script type="text/javascript">
					   window.___gcfg = {lang: 'pt-BR'};
					  (function() {
					    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
					    po.src = 'https://apis.google.com/js/plusone.js';
					    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
					  })();
					</script>
				    <!-- ============================= -->
				    <!-- Place this tag in your head or just before your close body tag. -->
					<script type="text/javascript" src="https://apis.google.com/js/plusone.js">
					  {lang: 'pt-BR'}
					</script>
					<!-- Place this tag where you want the share button to render. -->
					<div class="g-plus" data-action="share" data-annotation="bubble"></div>
				      
					<h2>Delivery Pizza Cloud</h2>
					<p>Fa&ccedil;a seu pedido</p>
				</div>
				
				<ul>

					<!-- ******** Nome *********** -->
					<li id="li_1"><label class="description" for="element_1">Nome
						</label> <span> <input id="nome" name="nome" required
							class="element text" maxlength="255" size="8" value="${sessionScope.user.nome}" <%=disableValue%>/> <label>Nome</label>
						</span> <span> <input id="sobrenome" name="sobrenome" required
							class="element text" maxlength="255" size="14" value="${sessionScope.user.sobrenome}" <%=disableValue%>/> <label>Sobrenome</label>
						</span>
					</li>
					
					<!-- ******** Endereco *********** -->
					<li id="li_3"><label class="description" for="element_3">Endere&ccedil;o</label>
						<div>
							<input id="endereco" name="endereco" class="element text large" required
								type="text" maxlength="255" value="${sessionScope.user.endereco}" <%=disableValue%>/>
						</div>
						<p class="guidelines" id="guide_3">
							<small>Exemplo: Rua General Osorio, 340</small>
						</p>
					</li>
					
					<!-- ******** Bairro *********** -->
					<li id="li_4"><label class="description" for="element_4">Bairro</label>
						<div>
							<input id="bairro" name="bairro" required
								class="element text medium" type="text" maxlength="255" value="${sessionScope.user.bairro}" <%=disableValue%>/>
						</div>
					</li>
					
					<!-- ******** Cidade *********** -->
					<li id="li_4">
						<label class="description" for="cidade">Cidade</label>
						<div>
							<input id="cidade" name="cidade" required
								class="element text medium" type="text" maxlength="255" value="${sessionScope.user.cidade}" <%=disableValue%>/>
						</div>
					</li>
					
					<!-- ******** Telefone *********** -->
					<li id="li_2">
						<label class="description" for="element_2">Telefone</label> 
						<span> 
							<input id="ddd" name="ddd" class="element text" size="2" placeholder="ddd" required
								maxlength="2" value="${fn:substring(sessionScope.user.telefone,0,2)}" type="text" <%=disableValue%>/>
							- <label for="element_2_1">99</label>
						</span> 
						
						<span><input id="numero" name="numero" class="element text" size="8" placeholder="numero" required
							maxlength="9" value="${fn:substring(sessionScope.user.telefone, 2, 11)}" type="text" <%=disableValue%>/>
							<label for="element_2_2">12345678</label>
						</span> 
						
					</li>
					
					<!-- ******** Pizza *********** -->
					<li id="li_5"><label class="description" for="element_5">Escolha sua Pizza </label>
						<div>
							<select required id="pizza" name="pizza" size="4" class="element select medium" multiple <%=disableValue%>>
							
								<c:forEach var="pizza" items="${applicationScope.pizzaList}">
									<option value="${pizza.key}">${pizza.nome}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					 
					<li class="buttons">
						<!-- ******** Submeter *********** -->
						<input id="saveForm" class="classname" type="submit" name="submit" value="Finalizar Pedido" <%=disableValue%>/>
						
					</li>
						
				</ul>
			</form>
			
		</div> 
		
		<div id="loading" style="display: none; vertical-align: middle;" align="center">	
			<br/><img align="bottom" style="" src="/form/loading.gif"/>
		</div>
		<div id="msg_erro" style="display: none;">
			Ops! Desculpe, parece que ocorreu algum problema, por favor tente novamente mais tarde.
		</div>
		<div id="response" style="display: none;"></div>
</body>
</html>