powershell -windowstyle hidden { # 隐藏命令行
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    #$form.Text = 'Data Entry Form'
    $form.Size = New-Object System.Drawing.Size(750,500)
    #$form.StartPosition = 'CenterScreen'
    $form.TopMost = $true


    $label = New-Object System.Windows.Forms.Label
    $Fonts = New-Object System.Drawing.Font("Mircosoft Yahei",12,[System.Drawing.FontStyle]::Regular)
    $label.Font = $Fonts
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(700,400)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,420)
    $textBox.Size = New-Object System.Drawing.Size(700,50)
    $Fonts = New-Object System.Drawing.Font("Mircosoft Yahei",12,[System.Drawing.FontStyle]::Regular)
    $textBox.Font = $Fonts

    $form.Topmost = $true # 窗口置顶

    $form.BackgroundImageLayout = 3 # 使图片跟随窗口大小缩放
    $form.MaximizeBox = $false # 屏蔽最大化按钮
    $click = {
        if(gcb){
            $label.Text = gcb
            $form.Controls.Add($label)
            $textBox.Text = gcb
            $form.Controls.Add($textBox)
            $form.BackgroundImage = $img0 # 清除背景图像
            $form.Size = New-Object System.Drawing.Size(750,500)
            
        }else{
            $data = [Windows.Forms.Clipboard]::GetDataObject(); # 获得剪贴板数据
            if ($data.GetDataPresent([Windows.Forms.DataFormats]::Bitmap)) {
                $form.Controls.Remove($label)
                $form.Controls.Remove($textBox)
                $img = $data.GetData([Windows.Forms.DataFormats]::Bitmap); # 将数据转换成图片
                $form.BackgroundImage = $img; # 把图片设为窗口背景
                $form.ClientSize = $img.Size; # 把窗口图片区域的大小设为和图片一样
           }
        }
    }
    $form.add_Click($click); # 添加点击事件
    Invoke-Command $click; # 先执行一次，把当前图片放进窗口
    $form.ShowDialog(); # 显示窗口
}