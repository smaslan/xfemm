/* Copyright 2017 Johannes Zarl-Zierl <johannes@zarl-zierl.at>
 *
 * The source code in this file is heavily derived from
 * FEMM by David Meeker <dmeeker@ieee.org>,
 * and modifications done by Richard Crozier <richard.crozier@yahoo.co.uk>
 * For more information on FEMM see http://www.femm.info
 * This modified version is not endorsed in any way by the original
 * authors of FEMM.
 *
 * License:
 * This software is subject to the Aladdin Free Public Licence
 * version 8, November 18, 1999.
 * The full license text is available in the file LICENSE.txt supplied
 * along with the source code.
 */

#ifndef LIBFEMM_ENUMS_H
#define LIBFEMM_ENUMS_H

namespace femm {

/**
 * @brief The EditMode determines which objects are affected by an edit or selection command.
 */
enum EditMode {
    /// \brief Operate on nodes
    EditNodes = 0,
    /// \brief Operate on line segments
    EditLines = 1,
    /// \brief Operate on block labels
    EditLabels = 2,
    /// \brief Operate on arc segments
    EditArcs = 3,
    /// \brief Operate on all object types
    EditGroup = 4,
    /// \brief An invalid value
    EditModeInvalid
};

/**
 * @brief Convert an integer value into an EditMode enum.
 * @param m
 * @return a valid EditMode for defined values, EditModeInvalid otherwise.
 */
inline EditMode intToEditMode(int m)
{
    switch (m) {
    case 0: return EditNodes;
    case 1: return EditLines;
    case 2: return EditLabels;
    case 3: return EditArcs;
    case 4: return EditGroup;
    default:
        return EditModeInvalid;
    }
}

/**
 * @brief The FileType enum determines how the problem description is written to disc.
 */
enum FileType { UnknownFile, MagneticsFile, HeatFlowFile, CurrentFlowFile, ElectrostaticsFile };
}

#endif