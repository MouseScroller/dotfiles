local package = {
    enable = false,
	url = "https://github.com/Darazaki/indent-o-matic",
}
 
package.setup = function()
	

end

package.init = function()
	return Split_package(package)
end

return package.init()