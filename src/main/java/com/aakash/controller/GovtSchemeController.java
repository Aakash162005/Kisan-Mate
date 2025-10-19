package com.aakash.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aakash.dao.GovtSchemeDao;
import com.aakash.model.GovtScheme;

@Controller
public class GovtSchemeController {

	ApplicationContext context = new ClassPathXmlApplicationContext("Config.xml");
    GovtSchemeDao govtSchemeDao = (GovtSchemeDao) context.getBean("govtSchemeDao");

    @RequestMapping(path = "/govtScheme", method = RequestMethod.POST)
    public String govtScheme(HttpServletRequest request, Model model) {

        // ✅ Create a fresh GovtScheme object for each request
        GovtScheme govtScheme = new GovtScheme();

        // ✅ Retrieve form parameters safely
        govtScheme.setsName(request.getParameter("sName"));
        govtScheme.setsCategory(request.getParameter("sCategory"));
        govtScheme.setsShortDescription(request.getParameter("sShortDescription"));
        govtScheme.setsEligibilityCriteria(request.getParameter("sEligibilityCriteria"));
        govtScheme.setsBenefits(request.getParameter("sBenefits"));
        govtScheme.setsRequiredDocuments(request.getParameter("sRequiredDocuments"));
        govtScheme.setsLink(request.getParameter("sLink"));
        govtScheme.setsStartDate(request.getParameter("sStartDate"));
        govtScheme.setsEndDate(request.getParameter("sEndDate"));

        System.out.println("Scheme Name from form: " + request.getParameter("sName"));

        
        // ✅ Save the scheme to DB
        govtSchemeDao.insertGovtScheme(govtScheme);

        // Redirect back to admin page
        return "redirect:/adminHome";
    }

	@RequestMapping("/govt_schemes")
	public String govtSchemes(Model model) {
		List<GovtScheme> schemes = govtSchemeDao.getAllGovtSchemes();
		model.addAttribute("schemes", schemes);
		return "govt_schemes";
	}

	
}
