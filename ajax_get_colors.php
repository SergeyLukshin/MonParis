<?php

include_once ("init.tpl");
ini_set(default_charset,"windows-1251");

switch ($_POST['action']){
                
        case "show_colors":

				$size = iconv("utf-8", "windows-1251", $_POST['size']);

				$query_tmp = "SELECT AttribID, Color, Count FROM MP_PRODUCT_ATTRIB WHERE ProductID = ".$_POST['product_id']." AND Size = '".$size."' ORDER BY Color";
				$result_tmp = mysql_query($query_tmp);		

				//echo "<option value='' class='bs-title-option'>Выберите цвет</option>";
                
                $i = 0;                
                while ($row_tmp = mysql_fetch_array($result_tmp)):
					if ($i == 0)
					{
						if ($row_tmp["Count"] > 0)
							echo "<option selected='selected' value='".$row_tmp["AttribID"]."$".$row_tmp["Color"]."' >".$row_tmp["Color"]." (на складе)</option>";
						else
							echo "<option selected='selected' value='".$row_tmp["AttribID"]."$".$row_tmp["Color"]."' >".$row_tmp["Color"]."</option>";
					}
					else
					{
						if ($row_tmp["Count"] > 0)
							echo "<option value='".$row_tmp["AttribID"]."$".$row_tmp["Color"]."' >".$row_tmp["Color"]." (на складе)</option>";
						else
							echo "<option value='".$row_tmp["AttribID"]."$".$row_tmp["Color"]."' >".$row_tmp["Color"]."</option>";
					}
					$i = $i + 1;
				endwhile;
                //echo '</select>';
                mysql_free_result($result_tmp);
                break;
        case "show_sizes":

				$color = iconv("utf-8", "windows-1251", $_POST['color']);
				
				if (isset($_SESSION["attribs"]))
				{
					$vec_product_attribs = $_SESSION["attribs"];
					
					if (array_key_exists($color, $vec_product_attribs))
					{
						$i = 0; 
						foreach ($vec_product_attribs[$color] as $key => $value_size) 
						{
							$size = $key;
							$size = str_replace("(", "(<span style = 'color: #8597DC;font-weight: bold'>", $size);
							$size = str_replace(")", "</span>)", $size);

							foreach ($value_size as $key2 => $value_attr) 
							{
								$attribID = $key2;

								if ($i == 0)
								{
									if ($value_attr > 0)
										echo "<a class='act' href='#' name='".$attribID."$".$key."'>".$size."</a>";
									else
										echo "<a class='act nocount' href='#' name='".$attribID."$".$key."'>".$key."</a>";
								}
								else
								{
									if ($value_attr > 0)
										echo "<a href='#' name='".$attribID."$".$key."'>".$size."</a>";
									else
										echo "<a href='#' class='nocount' name='".$attribID."$".$key."'>".$key."</a>";
								}
								$i = $i + 1;
							}
						}
					}   
				}
				else
				{
					$query_tmp = "SELECT AttribID, Size, Count FROM MP_PRODUCT_ATTRIB WHERE ProductID = ".$_POST['product_id']." AND Color = '".$color."' ORDER BY Size";
					$result_tmp = mysql_query($query_tmp);		

					$i = 0;                
					while ($row_tmp = mysql_fetch_array($result_tmp)):
					
						$size = $row_tmp["Size"];
						$size = str_replace("(", "(<span style = 'color: #8597DC;font-weight: bold'>", $size);
						$size = str_replace(")", "</span>)", $size);
					
						if ($i == 0)
						{
							if ($row_tmp["Count"] > 0)
								echo "<a class='act' href='#' name='".$row_tmp["AttribID"]."$".$row_tmp["Size"]."'>".$size."</a>";
							else
								echo "<a class='act nocount' href='#' name='".$row_tmp["AttribID"]."$".$row_tmp["Size"]."'>".$row_tmp["Size"]."</a>";
						}
						else
						{
							if ($row_tmp["Count"] > 0)
								echo "<a href='#' name='".$row_tmp["AttribID"]."$".$row_tmp["Size"]."'>".$size."</a>";
							else
								echo "<a href='#' class='nocount' name='".$row_tmp["AttribID"]."$".$row_tmp["Size"]."'>".$row_tmp["Size"]."</a>";
						}
						$i = $i + 1;
					endwhile;
					//echo '</select>';
					mysql_free_result($result_tmp);
				}
                break;
        
};

?>

