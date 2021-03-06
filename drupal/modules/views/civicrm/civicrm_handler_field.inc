<?php
/*
 +--------------------------------------------------------------------+
 | CiviCRM version 3.4                                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*/

/**
 * Field handler to provide simple renderer that allows linking to a user.
 *
 * @ingroup civicrm_field_handlers
 */
class civicrm_handler_field extends views_handler_field {
    /**
     * Override init function to provide generic option to link to user.
     */
    function init(&$view, &$data) {
        parent::init($view, $data);
    }

    /**
     * Provide link to node option
     */
    function options_form(&$form, &$form_state) {
        parent::options_form($form, $form_state);
        $form['link_to_civicrm'] = array(
                                         '#title' => t('Link this field to its user'),
                                         '#type' => 'checkbox',
                                         '#default_value' => $this->options['link_to_civicrm'],
                                         );
    }

    function render_link($data, $values) {
        if (!empty($this->options['link_to_civicrm']) && user_access('access CiviCRM') && $values->id) {
            return civicrm_views_href( $data,
                                      'civicrm/contact/view',
                                      "reset=1&cid={$values->id}" );
        }
        else {
            return $data;
        }
    }

    function render($values) {
        return $this->render_link(check_plain($values->{$this->field_alias}), $values);
    }
}
