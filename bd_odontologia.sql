-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-06-2025 a las 00:06:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_odontologia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(10) NOT NULL,
  `id_paciente` int(10) DEFAULT NULL,
  `id_dentista` int(10) DEFAULT NULL,
  `fecha_cita` date DEFAULT NULL,
  `hora_cita` datetime DEFAULT NULL,
  `id_tipo_cita` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `id_paciente`, `id_dentista`, `fecha_cita`, `hora_cita`, `id_tipo_cita`) VALUES
(8, 1104934178, NULL, '2025-05-28', '2025-05-28 09:00:00', 2),
(9, 1104934178, NULL, '2025-05-29', '2025-05-29 12:00:00', 2),
(10, 1104934178, NULL, '2025-05-31', '2025-05-31 11:00:00', 3),
(11, 1104934178, NULL, '2025-05-29', '2025-05-29 11:00:00', 1),
(12, 65632866, NULL, '2025-05-28', '2025-05-28 11:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnosticos`
--

CREATE TABLE `diagnosticos` (
  `id_diagnostico` varchar(6) NOT NULL,
  `nombre_diagnostico` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `diagnosticos`
--

INSERT INTO `diagnosticos` (`id_diagnostico`, `nombre_diagnostico`) VALUES
('K07.0', 'ANOMALÍAS DEL TAMAÑO DE LOS MAXILARES'),
('K07.1', 'ANOMALÍAS DE LA RELACIÓN MAXILOBASILAR'),
('K07.2', 'ANOMALÍAS DE LA RELACIÓN ENTRE LOS ARCOS DENTARIOS'),
('K07.3', 'ANOMALÍAS DE LA POSICIÓN DEL DIENTE'),
('K07.4', 'MALOCLUSIÓN DE TIPO NO ESPECIFICADO'),
('K07.5', 'ANOMALÍAS DENTOFACIALES FUNCIONALES'),
('K07.6', 'TRASTORNOS DE LA ARTICULACIÓN TEMPOROMANDIBULAR'),
('K07.8', 'OTRAS ANOMALÍAS DENTOFACIALES ESPECIFICADAS'),
('K07.9', 'ANOMALÍA DENTOFACIAL, NO ESPECIFICADA'),
('K08.0', 'ANODONCIA (AUSENCIA CONGÉNITA DE DIENTES)'),
('K08.1', 'PÉRDIDA DE DIENTES DEBIDA A ACCIDENTE, EXTRACCIÓN O ENFERMEDAD PERIODONTAL'),
('K08.2', 'ATROFIA DEL MAXILAR O MANDÍBULA POSTERIOR A LA PÉRDIDA DE DIENTES'),
('K08.8', 'OTRAS ANOMALÍAS ESPECIFICADAS DE LOS DIENTES Y ESTRUCTURAS DE SOPORTE'),
('Z01.2', 'EXAMEN ODONTOLÓGICO DE RUTINA'),
('Z46.4', 'COLOCACIÓN Y AJUSTE DE APARATO ORTODÓNCICO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historias_clinicas`
--

CREATE TABLE `historias_clinicas` (
  `id_historia` int(10) NOT NULL,
  `id_paciente` int(10) NOT NULL,
  `fecha_historia` datetime NOT NULL DEFAULT current_timestamp(),
  `id_diagnostico` varchar(6) NOT NULL,
  `id_procedimiento` int(6) DEFAULT NULL,
  `id_medicamento` int(6) DEFAULT NULL,
  `analisis` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historias_clinicas`
--

INSERT INTO `historias_clinicas` (`id_historia`, `id_paciente`, `fecha_historia`, `id_diagnostico`, `id_procedimiento`, `id_medicamento`, `analisis`) VALUES
(1, 1104934178, '2025-05-22 16:00:51', 'K07.6', NULL, NULL, 'PACIENTE REFIERE DOLOR AL MORDER, SE REALIZA CHEQUEO, SE OBSERVA LEVE RUPTURA EN PREMOLAR, SE LE INDICA CONTROL CON RESULTADO DE RX PARA CONTINUAR TRATAMIENTO'),
(2, 1104934178, '2025-05-22 11:00:51', 'K07.2', 247300, 250111, 'PACIENTE EL CUAL PRESENTA DOLOR EN DIENTE DEBIDO A CARIE'),
(3, 65632866, '2025-05-22 04:00:51', 'K07.4', 247300, 250103, 'PACIENTE FEMENINA CON RUPTURA DE MUELA DEBIDO A ACCIDENTE DE TRANSITO'),
(4, 65632866, '2025-05-22 12:00:51', 'K07.3', NULL, NULL, 'PACIENTE QUIEN ASISTE A CONTROL D CHEQUEO POST-OPERATORIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id_medicamento` int(6) NOT NULL,
  `nombre_medicamento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id_medicamento`, `nombre_medicamento`) VALUES
(250101, 'PARACETAMOL'),
(250102, 'IBUPROFENO'),
(250103, 'AMOXICILINA'),
(250104, 'CLINDAMICINA'),
(250105, 'CODEÍNA'),
(250106, 'LIDOCAÍNA'),
(250107, 'DIFENHIDRAMINA'),
(250108, 'CLORHEXIDINA'),
(250109, 'MIDAZOLAM'),
(250110, 'METRONIDAZOL'),
(250111, 'DICLOFENACO'),
(250112, 'AZITROMICINA'),
(250113, 'BENCIDAMINA'),
(250114, 'NISTATINA'),
(250115, 'LORATADINA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `id_medico` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `nombre_medico` varchar(50) DEFAULT NULL,
  `numero_licencia` int(10) DEFAULT NULL,
  `especialidad` varchar(50) DEFAULT NULL,
  `telefono_medico` varchar(10) NOT NULL,
  `direccion_medico` varchar(50) NOT NULL,
  `correo_medico` varchar(50) NOT NULL,
  `edad_medico` int(3) NOT NULL,
  `tipo_sangre_medico` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`id_medico`, `user_id`, `nombre_medico`, `numero_licencia`, `especialidad`, `telefono_medico`, `direccion_medico`, `correo_medico`, `edad_medico`, `tipo_sangre_medico`) VALUES
(1, 2, 'Dr. Juan Pérez', 1234567890, 'Odontología General', '3154822045', 'RICAURTEEEEE', 'medico@medico.com', 37, 'AB-');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id_paciente` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `nombre_paciente` varchar(50) DEFAULT NULL,
  `edad_paciente` int(3) DEFAULT NULL,
  `genero_paciente` varchar(1) DEFAULT NULL,
  `telefono_paciente` varchar(10) DEFAULT NULL,
  `direccion_paciente` varchar(50) DEFAULT NULL,
  `correo_paciente` varchar(50) DEFAULT NULL,
  `tipo_sangre` varchar(3) DEFAULT NULL,
  `foto_paciente` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`id_paciente`, `user_id`, `nombre_paciente`, `edad_paciente`, `genero_paciente`, `telefono_paciente`, `direccion_paciente`, `correo_paciente`, `tipo_sangre`, `foto_paciente`) VALUES
(65632866, 3, 'Evelin', 40, 'F', '3102946248', 'GALAN', 'dmmodestor@ut.edu.co', 'O+', NULL),
(1104934178, 1, 'Daniel Mauricio Modesto Ramirez', 21, 'M', '3138004358', 'Galan', 'dmmodestor@ut.edu.co', 'O+', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

CREATE TABLE `procedimientos` (
  `id_procedimiento` int(6) NOT NULL,
  `nombre_procedimiento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `procedimientos`
--

INSERT INTO `procedimientos` (`id_procedimiento`, `nombre_procedimiento`) VALUES
(230103, 'EXODONCIA DE DIENTES PERMANENTES'),
(231303, 'EXODONCIA DE DIENTE INCLUIDO'),
(233101, 'RESTAURACION DE DIENTES MEDIANTE INCRUSTACION METALICA'),
(247100, 'COLOCACIÓN DE APARATOLOGÍA FIJA PARA ORTODONCIA (ARCADA)'),
(247300, 'COLOCACIÓN DE APARATOS DE RETENCIÓN'),
(870001, 'RADIOGRAFÍA DE CRÁNEO SIMPLE'),
(870114, 'RADIOGRAFÍA PANORÁMICA DE MAXILARES, SUPERIOR E INFERIOR'),
(890222, 'CONSULTA DE PRIMERA VEZ POR ESPECIALISTA EN ORTODONCIA'),
(890322, 'CONSULTA DE CONTROL O DE SEGUIMIENTO POR ESPECIALISTA EN ORTODONCIA'),
(893101, 'IMPRESIÓN DE ARCO DENTARIO SUPERIOR O INFERIOR, CON MODELO DE ESTUDIO Y CONCEPTO'),
(893102, 'FOTOGRAFÍA CLÍNICA EXTRAORAL, INTRAORAL, FRONTAL O LATERAL'),
(973400, 'EXTRACCIÓN DE APARATOLOGÍA ORTODÓNTICA FIJA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(10) NOT NULL,
  `rol_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_name`) VALUES
(1, 'USUARIO'),
(2, 'MEDICO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cita`
--

CREATE TABLE `tipo_cita` (
  `id_tipo_cita` int(10) NOT NULL,
  `nombre_tipo_cita` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_cita`
--

INSERT INTO `tipo_cita` (`id_tipo_cita`, `nombre_tipo_cita`) VALUES
(1, 'Consulta Externa'),
(2, 'Procedimiento'),
(3, 'Imagenes Diagnosticas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `user_id` int(10) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role_id` int(10) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`user_id`, `username`, `password_hash`, `role_id`, `id_paciente`) VALUES
(1, 'USUARIO', '12345', 1, 1104934178),
(2, 'MEDICO', '12345', 2, NULL),
(3, 'USUARIO2', '12345', 1, 65632866);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_dentista` (`id_dentista`),
  ADD KEY `id_tipo_cita` (`id_tipo_cita`);

--
-- Indices de la tabla `diagnosticos`
--
ALTER TABLE `diagnosticos`
  ADD PRIMARY KEY (`id_diagnostico`);

--
-- Indices de la tabla `historias_clinicas`
--
ALTER TABLE `historias_clinicas`
  ADD PRIMARY KEY (`id_historia`),
  ADD KEY `id_medicamento` (`id_medicamento`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `fk_hist_clinicas_diagnostico` (`id_diagnostico`),
  ADD KEY `fk_historia_procedimiento` (`id_procedimiento`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id_medicamento`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`id_medico`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id_paciente`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  ADD PRIMARY KEY (`id_procedimiento`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  ADD PRIMARY KEY (`id_tipo_cita`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `fk_usuario_paciente` (`id_paciente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id_paciente`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_dentista`) REFERENCES `medico` (`id_medico`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_tipo_cita`) REFERENCES `tipo_cita` (`id_tipo_cita`);

--
-- Filtros para la tabla `historias_clinicas`
--
ALTER TABLE `historias_clinicas`
  ADD CONSTRAINT `fk_hist_clinicas_diagnostico` FOREIGN KEY (`id_diagnostico`) REFERENCES `diagnosticos` (`Id_diagnostico`),
  ADD CONSTRAINT `fk_historia_procedimiento` FOREIGN KEY (`id_procedimiento`) REFERENCES `procedimientos` (`Id_procedimiento`),
  ADD CONSTRAINT `historias_clinicas_ibfk_2` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`Id_medicamento`),
  ADD CONSTRAINT `historias_clinicas_ibfk_4` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id_paciente`);

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`user_id`);

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`user_id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id_paciente`),
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
