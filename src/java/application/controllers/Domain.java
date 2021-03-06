/*
    Recite18th is a simple, easy to use and straightforward Java Database 
    Web Application Framework. See http://code.google.com/p/recite18th
    Copyright (C) 2011  Eko Suprapto Wibowo (swdev.bali@gmail.com)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/.
 */
package application.controllers;

import application.models.DomainModel;
import recite18th.controller.Controller;

/**
 *
 * @author rukli
 */
public class Domain extends Controller {

    public Domain() {
        modelForm = new DomainModel();
        controllerName = "domain";
        viewPage = "domain/daftar_domain.jsp";
        formPage = "domain/form_domain.jsp";
        sqlViewDataPerPage = "select * from domain order by domain";
        
        //validation
        validationAddRule("domain", "required");
    }
}
