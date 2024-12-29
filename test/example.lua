--!strict
local tailblox = ...

local dark_theme: tailblox.Theme = tailblox({
	BackgroundColor3 = Color3.fromRGB(14,14,14),
	
	convert_icon_to_dark = function (imageBase: (ImageLabel | ImageButton))
		assert(typeof(imageBase) == "ImageLabel" or "ImageButton", "[convert_icon_to_dark]: Assertion failed.")
		imageBase.ImageColor3 = Color3.fromRGB(31, 31, 31)
	end,
	
	return_population_of_country = function (country: string): number?
		assert(typeof(country) == "string", "[return_population_of_country]: Assertion failed.")
		local countryData = game:GetService("HttpService"):JSONDecode(
			game:GetService("HttpService"):GetAsync(`https://restfulcountries.com/api/v1/countries/{country}`)
		)
		print(countryData["data"]["population"] or "")
		return countryData["data"]["population"] or nil
	end,
	
})

local light_theme: tailblox.Theme = tailblox({
	BackgroundColor3 = Color3.fromRGB(222, 222, 222),

	convert_icon_to_dark = function (imageBase: (ImageLabel | ImageButton))
		assert(typeof(imageBase) == "ImageLabel" or "ImageButton", "[convert_icon_to_dark]: Assertion failed.")
		imageBase.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end,
})

local countriesList = {
	"China",
	"Morocco",
	"England",
	"France"
}

local menuPage: Frame = Instance.new("Frame")
local logo: ImageLabel = Instance.new("ImageLabel")
task.wait(2)
light_theme.apply(menuPage)
light_theme:run("convert_icon_to_dark", logo)
task.wait(5)
dark_theme.apply(menuPage)
dark_theme:run("return_population_of_country", countriesList[math.random(1, #countriesList)])
