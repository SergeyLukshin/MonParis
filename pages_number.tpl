<?php
	// $rowCount - общее кол-во товаров
	// $cur_page - текущее кол-во товаров
	// $cnt_on_page - кол-во товаров на странице
	
	$tmp = (($cur_page) * $cnt_on_page);
	if ($tmp > $rowCount) $tmp = $rowCount;
	
	if ($cnt_pages > 1)
	{
		echo("<div class='paginat_out'>");
		echo("<div class='paginat_inn'>");

		if ($cur_page > 1)
		{
			//if (($cur_page - 1) == 1)
			//	echo "<a class='str str_lf' href='/".$url_str."'></a>";
			//else
				echo "<a class='str str_lf' href='/".$url_str."/".($cur_page - 1)."'></a>";
		}
		
		$page_index = 1;
		if ($page_index != $cur_page)
		{
			//if ($page_index == 1)
			//	echo "<a href='/".$url_str."'><span>".$page_index."</span></a>";
			//else
				echo "<a href='/".$url_str."/".$page_index."'><span>".$page_index."</span></a>";
		}
		else
		{
			// ссылку убрать
			echo "<span class='act'><span>".$page_index."</span></span>";
		}
			
		if ($cnt_pages > 1)
		{
			$page_index = 2;
			$was_points = 0;
			while ($page_index <= $cnt_pages - 1):
				if (abs($cur_page - $page_index) > 3)
				{
					if ($was_points == 0)
					{
						// ссылку убрать
						echo "<span><span>...</span></span>";
						$was_points = 1;
					}
					$page_index = $page_index + 1;
					continue;
				}
				
				if ($page_index != $cur_page)
				{
					//if ($page_index == 1)
					//	echo "<a href='/".$url_str."'><span>".$page_index."</span></a>";
					//else
						echo "<a href='/".$url_str."/".$page_index."'><span>".$page_index."</span></a>";
				}
				else
				{
					// ссылку убрать
					echo "<span class='act'><span>".$page_index."</span></span>";
				}
					
				$was_points = 0;
				
				$page_index = $page_index + 1;
			endwhile;
		
			$page_index = $cnt_pages;
			if ($page_index != $cur_page)
				echo "<a href='/".$url_str."/".$page_index."'><span>".$page_index."</span></a>";
			else
			{
				// ссылку убрать
				echo "<span class='act'><span>".$page_index."</span></span>";
			}
		}
		if ($cur_page < $cnt_pages)
		{
			echo "<a class='str str_rg' href='/".$url_str."/".($cur_page + 1)."'></a>";
		}		

		echo("</div></div>");
	}
?>
