<?php
	$strTitle = "������� �����������";
	$opt_page = 1;
	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">�������</a></li>
            <li>������� �����������</li>
        </ul>



        <div class="opt_out">
            <ul class="opt_tabs_nav">
                <li><a class="act" href="/opt.php"><span>������� �����������</span></a></li>
                <li><a href="/samovyvoz.php"><span>���������</span></a></li>
                <li><a href="/delivery.php"><span>��������</span></a></li>
            </ul>
            <div class="opt_tabs_cont">

                <h2 class="txt_title">������� � ���������� ���������� ������� �������</h2>

                <!--<div class="form">
                    <div class="form_inn">

                        <h5>�� �������� ���. �������</h5>
                        <div class="clearfix"></div>
                        <form name="form_opt_send" action="?f=1" method="POST">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="���� ���">
                            </div>
                            <div class="form-group has-error">
                                <input type="text" class="form-control" placeholder="��� e-mail">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="����� ��������">
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" placeholder="�������������"></textarea>
                            </div>
                            <button class="form_butt_1" name="send" type="submit" value="send_form"><span>���������</span></button>
                        </form>
                    </div>

                    <div class="reg_ent_bl">
                        <div class="lnk"><a href="#">�����������</a></div>
                        <div class="rz"></div>
                        <div class="lnk"><a href="#">����</a></div>
                    </div>

                </div> -->

                <div class="txt">

                    <p>��������� ����������� �������� <strong>MonParis</strong> �������� ��� ���, ����� ���� ������� ������ ����� ��������� ��������������� �� ���� �������� ������. �������� �� ����� ���� ��������, ������������ ��������� � ������������ ����� ����� ���������� ��� ���� ���������, �� �������, ��� ������� ������ <strong>MonParis</strong> ���������� ���������� �������� ������ �������� � ��������� ��� ���� ������ � ������ ����� �����������. ��������� ����������� �������� <strong>MonParis</strong> �������� ��� ���, ����� ���� ������� ������ ����� ��������� ��������������� �� ���� �������� ������. �������� �� ����� ���� ��������, ������������ ��������� � ������������ ����� ����� ���������� ��� ���� ���������, �� �������, ��� ������� ������ <strong>MonParis</strong> ���������� ���������� �������� ������. ��������� ����������� �������� <strong>MonParis</strong> �������� ��� ���, ����� ���� ������� ������ ����� ��������� ��������������� �� ���� �������� ������. �������� �� ����� ���� ��������, ������������ ��������� � ������������ ����� ����� ���������� ��� ���� ���������, �� �������, ��� ������� ������ <strong>MonParis</strong> ���������� ���������� �������� ������ �������� � ��������� ��� ���� ������ � ������ ����� �����������.</p>

                    <p>��������� ����������� �������� <strong>MonParis</strong> �������� ��� ���, ����� ���� ������� ������ ����� ��������� ��������������� �� ���� �������� ������. �������� �� ����� ���� ��������, ������������ ��������� � ������������ ����� ����� ���������� ��� ���� ���������, �� �������, ��� ������� ������ <strong>MonParis</strong> ���������� ���������� �������� ������ �������� � ��������� ��� ����. ��������� ����������� �������� <strong>MonParis</strong> �������� ��� ���, ����� ���� ������� ������ ����� ��������� ��������������� �� ���� �������� ������. �������� �� ����� ���� ��������, ������������ ��������� � ������������ ����� ����� ���������� ��� ���� ���������, �� �������, ��� ������� ������ <strong>MonParis</strong> ���������� ���������� �������� ������ �������� � ��������� ��� ���� ������ � ������ ����� �����������.</p>

                </div>

            </div>
        </div>

<?php

	if (file_exists("catalog/opt.tpl"))
	{
		include "catalog/opt.tpl";
	}

	include_once ("bottom.tpl");
?> 
